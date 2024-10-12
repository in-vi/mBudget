//
//  User.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import Foundation

struct User : Codable{
    
    let id : String
    let name : String
    let email : String
    let joined : TimeInterval
}
