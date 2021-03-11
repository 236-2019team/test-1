//
//  KeychainItemStorable.swift
//  test 1
//
//  Created by Ron on 3/10/21.
//

import Foundation

struct KeychainItemStorable {
    let service: String
    let account: String
}
extension KeychainItemStorable {
    enum Error: Swift.Error {
        case passwordNotFound
        case unknownError(String)
        case invalidData
    }
    func readPassword() throws -> String {
        var query: [String : Any] = [:]
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service
        query[kSecAttrAccount as String] = account as AnyObject?
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        switch status {
        case noErr:
            guard let items = queryResult as? [String: Any],
                let valueData = items[kSecValueData as String] as? Data,
                let valueString = String(data: valueData, encoding: .utf8) else
            { throw Error.invalidData }
            return valueString
        case errSecItemNotFound:
            throw Error.passwordNotFound
        default:
            throw Error.unknownError(status.description)
        }
    }
}
