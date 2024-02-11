//
//  UserObject.swift
//  LMessenger
//
//  Created by 박진성 on 2/12/24.
//

import Foundation


struct UserObject : Codable {
    var id : String
    var name : String
    var phoneNumber : String?
    var profileURL : String?
    var description : String?
}
