//
//  Message.swift
//  breakpoint
//
//  Created by Chris Mercer on 24/04/2020.
//  Copyright © 2020 Chris Mercer. All rights reserved.
//

import Foundation

class Message {
    private var _content: String
    private var _senderId: String
    
    public var content: String {
        return _content
    }
    
    public var senderID : String {
        return _senderId
    }
    
    init(content: String, senderId: String) {
        self._content = content
        self._senderId = senderId
    }
}
