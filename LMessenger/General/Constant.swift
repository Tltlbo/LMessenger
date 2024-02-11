//
//  Constant.swift
//  LMessenger
//
//  Created by 박진성 on 2/12/24.
//

import Foundation

typealias DBKey = Constant.DBKey

enum Constant {}

extension Constant {
    struct DBKey {
        static let Users = "Users"
        static let ChatRooms = "ChatRooms"
        static let Chats = "Chats"
    }
}

