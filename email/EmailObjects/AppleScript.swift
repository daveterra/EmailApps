//
//  AppleScript.swift
//  email
//
//  Created by David Terra on 9/9/20.
//  Copyright © 2020 David Terra. All rights reserved.
//

//
// This should probably a pod or cocoa nut or whatever.

import Foundation
import CoreServices

class ScriptPermissions: ObservableObject {
    @Published var enabled: Bool
    private let notesBundleAddress = NSAppleEventDescriptor(bundleIdentifier: "com.apple.Mail")
    
    init() {
        let status = AEDeterminePermissionToAutomateTarget(self.notesBundleAddress.aeDesc!, typeWildCard, typeWildCard, true);
        if (status != .zero) {
            // TODO: Real error handling
            print("Could not obtain permission")
            self.enabled = false
        } else {
            self.enabled = true
        }
    
    }
    
    func check() {
        let status = AEDeterminePermissionToAutomateTarget(self.notesBundleAddress.aeDesc!, typeWildCard, typeWildCard, true);
        if (status != .zero) {
            // TODO: Real error handling
            print("Could not obtain permission")
            self.enabled = false
        } else {
            self.enabled = true
        }
    }
}


protocol AppleScript {
    associatedtype resultType
    var source : String { get }
    func result() -> resultType
}

private extension AppleScript {
    func execute() -> NSAppleEventDescriptor {
        let appleScript = NSAppleScript(source: self.source)!
        print(self.source)
                
        var errors: NSDictionary? = nil
        let scriptResult = appleScript.executeAndReturnError(&errors)
        
        if (errors != nil) {
            // TODO: Real error handling
            print("Errors running script: \(String(describing: errors))")
        }
        
        return scriptResult
    }
    
    func _result() -> String {
        let scriptResult = self.execute()
        return (scriptResult.stringValue) ?? ""
    }
    
    func _result() -> [String] {
        var ret = [String]()
        let scriptResult = self.execute()
        scriptResult.coerce(toDescriptorType: typeAEList)
        for index in 0 ..< scriptResult.numberOfItems {
            let adjustedIndex = index + 1 // Because...why? Who knows!
            if let thisDescriptor = scriptResult.atIndex((adjustedIndex)),
                let thisString = thisDescriptor.stringValue {
                ret.append(thisString)
            }
        }
    
        return ret
    }
    
    func _result() -> [(String,String)] {
        var ret1 = [String]()
        var ret2 = [String]()
        let scriptResult = self.execute()
        scriptResult.coerce(toDescriptorType: typeAEList)
        
        if let first = scriptResult.atIndex(1) {
            first.coerce(toDescriptorType: typeAEList)
            for index in 0 ..< first.numberOfItems {
                let adjustedIndex = index + 1 // Because...why? Who knows!
                if let thisDescriptor = first.atIndex((adjustedIndex)),
                    let thisString = thisDescriptor.stringValue {
                    ret1.append(thisString)
                }
            }
        }
        
        if let second = scriptResult.atIndex(2) {
            second.coerce(toDescriptorType: typeAEList)
            for index in 0 ..< second.numberOfItems {
                let adjustedIndex = index + 1 // Because...why? Who knows!
                if let thisDescriptor = second.atIndex((adjustedIndex)),
                    let thisString = thisDescriptor.stringValue {
                    ret2.append(thisString)
                }
            }
        }
    
        return Array(zip(ret1, ret2))
    }
    
    func _result() -> Date {
        let scriptResult = self.execute()
        if let date = scriptResult.dateValue {
            return date
        }
        return Date()
    }
}


// Scripts
// Must be declared in same file since we are using private extention
// I do wish there were a better way of organizing this, Ideally, I'd
// keep the scripts with their associated storage objects, but whatever. 

struct ScriptGetAccounts : AppleScript {
    typealias resultType = [(id: String, name: String)]
    var source: String = """
    tell application "Mail"
        {id, name} of every account
    end tell
    """
    
    func result() -> [(id: String, name: String)] {
        return self._result()
    }
}

struct ScriptGetMailboxes: AppleScript {
    typealias resultType = [String]
    var source: String
    
    init(forAccount account: EmailAccount) {
        self.source = """
        tell application "Mail"
            tell account id "\(account.id)"
                name of every mailbox
            end tell
        end tell
        """
    }
    
    func result() -> [String] {
        return self._result()
    }
}
