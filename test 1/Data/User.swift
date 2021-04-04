//
//  User.swift
//  test 1
//
//  Created by students on 3/4/21.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct User {
  
  let uid: String
  let email: String
  
  init(authData: FirebaseAuth.User) {
    uid = authData.uid
    email = authData.email!
  }
  
  init(uid: String, email: String) {
    self.uid = uid
    self.email = email
  }
}
