//
//  EmailAccount.swift
//  email
//
//  Created by David Terra on 9/9/20.
//  Copyright © 2020 David Terra. All rights reserved.
//

import Foundation

class EmailAccount {
    var name: String = ""
    var id: String = ""
    var isEnabled = false
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
}
