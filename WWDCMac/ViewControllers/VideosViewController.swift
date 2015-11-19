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
        
        let a = NSApplication.sharedApplication().windows[0].contentViewController as! MainViewController
        
        sessions = JSONReader.sharedReader.sessionsInYear(a.tabView.selectedTabViewItem?.identifier as! Int)
        tableView.reloadData()
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
        
        return true
    }
}
