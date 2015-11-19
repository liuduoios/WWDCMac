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

class SessionDetailViewController: NSViewController {

    @IBOutlet weak var titleField: NSTextField!
    
    var session: Session?
    @IBOutlet weak var closeButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        closeButton.hidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleSelectedSessionNotification:", name: "SelectedSession", object: nil)
    }
    
    func handleSelectedSessionNotification(notification: NSNotification) {
        let session = notification.userInfo!["session"] as! Session
        self.session = session
        
        titleField.stringValue = session.title!
    }
    
    @IBAction func play(sender: AnyObject) {
        
//        av.pre
        if let url = self.session?.video_url {
            print(url)
            let av = AVPlayerView(frame: self.view.bounds)
            let player = AVPlayer(URL: NSURL(string: url)!)
            av.player = player
            player.play()
            self.view.addSubview(av)
            
        }
    }
    
}
