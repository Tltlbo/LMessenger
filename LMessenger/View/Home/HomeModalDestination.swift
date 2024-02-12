//
//  HomeModalDestination.swift
//  LMessenger
//
//  Created by 박진성 on 2/12/24.
//

import Foundation

enum HomeModalDestination : Hashable, Identifiable {
    case myProfile
    case otherProfile(String)
    
    var id : Int {
        hashValue
    }
}
