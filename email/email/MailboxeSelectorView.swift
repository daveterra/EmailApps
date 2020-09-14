//
//  MailboxeSelectorView.swift
//  email
//
//  Created by David Terra on 9/9/20.
//  Copyright © 2020 David Terra. All rights reserved.
//

import SwiftUI

struct test: Identifiable {
    let id = UUID()
    let title: String = "Test"
    var children: [test]?
}

struct MailboxeSelectorView: View {
    
    let testItems = [test]()
    let fetcher = Fetcher()
    @ObservedObject var permission: ScriptPermissions = ScriptPermissions()
    
    var body: some View {
        VStack {
            if (!permission.enabled) {
                Text("Not authorized").font(.title)
                Text("You must authorize this app to access the Notes App. To do so:")
                    .padding(8)
                Text("1. Open \"System Preferences\"\n2. Navigate to \"Security & Privacy\"\n3. On the \"Privacy\" tab find \"Automation\"\n4. Find \"Note Export\" and enable \"Notes\"")
                 .multilineTextAlignment(.leading)
                .lineSpacing(6)
                .padding(8)
                Button("Check Permissions") {
                    self.permission.check()
                }
            } else {
                
                    List(testItems) {
                        item in
                        Text(item.title)
                    }
                    
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    Button("Fetch") {
                        let accounts = self.fetcher.fetchAccounts()
                        for account in accounts {
                            self.fetcher.fetchMailboxes(forAccount: account)
                        }
                    }
            }
        } .frame(width: 300, height: 485, alignment: .center) // 1.6180339887498948 ratio
    }
}

struct MailboxeSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        MailboxeSelectorView()
    }
}
