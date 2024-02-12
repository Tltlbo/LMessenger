//
//  DBError.swift
//  LMessenger
//
//  Created by 박진성 on 2/12/24.
//

import Foundation

enum DBError : Error {
    case error(Error)
    case emptyValue
    case invalidatedType
}
