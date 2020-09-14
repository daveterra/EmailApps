//
//  Fetcher.swift
//  email
//
//  Created by David Terra on 9/10/20.
//  Copyright © 2020 David Terra. All rights reserved.
//

import Foundation

class Fetcher {
    
    func fetchAccounts() -> [EmailAccount] {
        var accounts = [EmailAccount]()
        let script   = ScriptGetAccounts()
        let results  = script.result()
        for result in results {
            print(result)
            let account = EmailAccount(name: result.name, id: result.id)
            accounts.append(account)
        }
        return accounts
    }
    
    func fetchMailboxes(forAccount account: EmailAccount) -> [EmailMailbox] {
        var mailboxes = [EmailMailbox]()
        let script    = ScriptGetMailboxes(forAccount: account)
        let results   = script.result()

        for result in results {
            print(result)
            let mailbox = EmailMailbox(name: result)
            mailboxes.append(mailbox)
        }
        return mailboxes
    }
}
