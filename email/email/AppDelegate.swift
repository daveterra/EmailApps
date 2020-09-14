//
//  AppDelegate.swift
//  email
//
//  Created by David Terra on 9/9/20.
//  Copyright © 2020 David Terra. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = MailboxeSelectorView()

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 300, height: 485),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Will it though? Will it...?
    }
}



/*

class Node: NSObject {
    
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate { // }, NSOutlineViewDataSource, NSOutlineViewDelegate {

    @IBOutlet weak var window: NSWindow!
    //@IBOutlet weak var outlineView: NSOutlineView!
    @IBOutlet weak var outlineView: NSOutlineView!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let index = 0
        outlineView.scrollRowToVisible(index)
        outlineView.expandItem(nil, expandChildren: true)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
    func outlineView(_ view: NSOutlineView, numberOfChildrenOfItem: Any?) -> Int
    {
        print(numberOfChildrenOfItem ?? "Shit null, bro")
        return 0
    }
    
    func outlineView(_ outlineView: NSOutlineView,
                     child index: Int, ofItem item: AnyObject?) -> AnyObject {
        print(item ?? "Shit null, bro")
        return Node()
    }
    
    func outlineView(_ outlineView: NSOutlineView, child: Int, ofItem: Any?) -> Any {
        print(ofItem ?? "Shit null, bro")
        return Node()
    }
}
*/
