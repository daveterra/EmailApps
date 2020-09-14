//
//  EmailMailbox.swift
//  email
//
//  Created by David Terra on 9/10/20.
//  Copyright © 2020 David Terra. All rights reserved.
//

import Foundation




class EmailMailbox{
    var name: String = ""
    var unreadCount  = 0
    var isEnabled    = false
    
    init(name: String) {
        self.name = name
    }
}
