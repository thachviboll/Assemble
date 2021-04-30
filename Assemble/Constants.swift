//
//  Constants.swift
//  Assemble
//
//  Created by Trevor Baba on 4/23/21.
//

import Foundation
import UIKit

struct K {
    static let userCollection = "user"
    static let userG = "groups"
    static let groupCollection = "Groups"
    static let uid = "uid"
    static let username = "username"
    static let event = "Events"
    static let description = "description"
    static let location = "location"
    static let date = "date"
    
    
    struct Group {
        static let groupID = "_id"
        static let members = "members"
        static let name = "name"
        static let events = "events"
    }
    
    struct Event {
        static let name = "name"
        static let date = "date"
        static let des = "description"
        static let loc = "location"
        static let dateCreated = "date created"
        static let groupID = "group ID"
    }
}
