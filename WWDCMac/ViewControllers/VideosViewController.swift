//
//  VideosViewController.swift
//  WWDCMac
//
//  Created by 刘铎 on 15/11/18.
//  Copyright © 2015年 刘铎. All rights reserved.
//

import Cocoa

class VideosViewController: NSViewController {

    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var tableView: NSTableView!
    
    var sessions: [Session]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        let mainViewController = NSApplication.sharedApplication().windows[0].contentViewController as! MainViewController
        let identifier = mainViewController.tabView.selectedTabViewItem?.identifier as! String
        
        if identifier == "Tech Talks 2013" {
            sessions = JSONReader.sharedReader.techTalkSessions()
        } else {
            sessions = JSONReader.sharedReader.sessionsInYear(mainViewController.tabView.selectedTabViewItem?.identifier as! String)
        }
        
        tableView.reloadData()
        
        if tableView.selectedRow < 0 {
            tableView.selectRowIndexes(NSIndexSet(index: 0), byExtendingSelection: false)
            
            let session = sessions[0]
            
            NSNotificationCenter.defaultCenter().postNotificationName(
                "SelectedSession",
                object: nil,
                userInfo: ["session": session]
            )
        }
    }
    
}

extension VideosViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return sessions != nil ? sessions.count : 0
    }
}

extension VideosViewController: NSTableViewDelegate {
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeViewWithIdentifier("video", owner: tableView) as! VideoTableCellView
        
        let session = sessions[row]
        cell.titleField.stringValue = session.title!
        
        return cell
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        let session = sessions[row]
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            "SelectedSession",
            object: nil,
            userInfo: ["session": session]
        )
        NSNotificationCenter.defaultCenter().postNotificationName(
            "SelectedSessionClose",
            object: nil,
            userInfo: ["session": session]
        )
        
        return true
    }
}
