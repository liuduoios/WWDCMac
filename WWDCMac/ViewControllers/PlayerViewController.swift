//
//  PlayerViewController.swift
//  WWDCMac
//
//  Created by 刘铎 on 15/11/20.
//  Copyright © 2015年 Derek Liu. All rights reserved.
//

import Cocoa
import AVKit
import AVFoundation
import Async

class PlayerViewController: NSViewController {

    @IBOutlet weak var indicator: NSProgressIndicator!
    @IBOutlet weak var playerView: AVPlayerView!
    @IBOutlet weak var closeButton: NSButton!
    
    var url: String
    
    init(url: String) {
        self.url = url
        super.init(nibName: "PlayerViewController", bundle: nil)!
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView.wantsLayer = true
        playerView.showsFullScreenToggleButton = true
        closeButton.wantsLayer = true
        
        playerView.layer?.zPosition = 0
        closeButton.layer?.zPosition = 1
        indicator.layer?.zPosition = 1
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleSelectedTabViewItemNotification:", name: "SelectedTabViewItem", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleSelectedSessionNotification:", name: "SelectedSessionClose", object: nil)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        let player = AVPlayer(URL: NSURL(string: url)!)
        playerView.player = player
        player.play()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        destorySelf()
    }
    
    private func destorySelf() {
        closeButton?.removeFromSuperview()
        playerView?.player?.pause()
        playerView?.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        self.closeButton.hidden = false
        
    }
    
    override func mouseExited(theEvent: NSEvent) {
        self.closeButton.hidden = true
    }    
    
    // ---------------------------
    // MARK:- Notification Handler
    // ---------------------------
    
    @objc private func handleSelectedTabViewItemNotification(notification: NSNotification) {
        destorySelf()
    }
    
    @objc private func handleSelectedSessionNotification(notification: NSNotification) {
        destorySelf()
    }
}
