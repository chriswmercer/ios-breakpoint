//
//  Group.swift
//  breakpoint
//
//  Created by Chris Mercer on 25/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import Foundation

class Group {
    public private(set) var name: String
    public private(set) var description: String
    public private(set) var count: Int
    public private(set) var members: [String]
    
    init(name: String, description: String, members: [String]) {
        self.name = name
        self.description = description
        self.members = members
        self.count = members.count
    }
}
