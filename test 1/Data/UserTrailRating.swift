//
//  UserTrailRating.swift
//  test 1
//
//  Created by Ron on 3/26/21.
//

import Foundation

import FirebaseDatabase
import FirebaseAuth
import FirebaseCore

struct UserTrailRating {
  
  let uid: String
//  let date: String
//    let trailname: String
    
  
  init(authData: FirebaseAuth.User) {
    uid = authData.uid
    
  }
  
}
