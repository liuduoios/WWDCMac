//
//  SessionDetailViewController.swift
//  WWDCMac
//
//  Created by 刘铎 on 15/11/18.
//  Copyright © 2015年 刘铎. All rights reserved.
//

import Cocoa
import AVKit
import AVFoundation
import SnapKit

class SessionDetailViewController: NSViewController {

    @IBOutlet weak var titleField: NSTextField!
    @IBOutlet weak var summaryField: NSTextField!
    
    var session: Session?
    @IBOutlet weak var closeButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleSelectedSessionNotification:", name: "SelectedSession", object: nil)
    }
    
    func handleSelectedSessionNotification(notification: NSNotification) {
        let session = notification.userInfo!["session"] as! Session
        self.session = session
        
        titleField.stringValue = session.title!
        summaryField.stringValue = session.description!
    }
    
    @IBAction func play(sender: AnyObject) {
        if let url = self.session?.video_url {
            let playerViewController = PlayerViewController(url: url)
            self.view.addSubview(playerViewController.view)
            self.addChildViewController(playerViewController)
            
            playerViewController.view.snp_makeConstraints(closure: { make in
                make.edges.equalTo(self.view.snp_edges)
            })
        }
    }
    
}
