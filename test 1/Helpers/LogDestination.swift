//
//  LogDestination.swift
//  test 1
//
//  Created by Ron on 3/30/21.
//

import Foundation

final class LogDestination: TextOutputStream {
  private let path: String
  init() {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    path = paths.first! + "/logger.txt"
    //path="/Users/ron/Desktop/logger.txt"
    print ("log path:",path)
    
  }

  func write(_ string: String) {
   // print ("Writing to path ",path,"value",string)
    
    if let data = string.data(using: .utf8), let fileHandle = FileHandle(forWritingAtPath: path) {
        print ("data:",data)

      defer {
        fileHandle.closeFile()
      }
      fileHandle.seekToEndOfFile()
      fileHandle.write(data)
    }
  }
}
