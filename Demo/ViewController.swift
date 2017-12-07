//
//  ViewController.swift
//  Test
//
//  Created by Prethush on 09/06/16.
//  Copyright © 2016 Jackpot Rising Inc. All rights reserved.
//

import UIKit
import JackpotRising
import AVKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate, JackpotRisingDelegate {

    let playerController = AVPlayerViewController()
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    @IBOutlet weak var uxTxtScore: UITextField!
    //let sharedInstance = JackpotRising()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        JackpotRising.sharedInstance.initWithClientCredentials("W6OPDPNV6WRI3EWN2QANYSE64R4PA4YOD2XJLFNVHPTFLE6YRM7QLSC2",
                                                               clientSecret: "U64OJTGODKK7SGXTN6QC5XKXZ4YZRM6ZZPZQR2KTIJRV4O5YNNZY3VT5")
        JackpotRising.sharedInstance.delegate = self
        JackpotRising.sharedInstance.pointingURL = .staging
        JackpotRising.sharedInstance.testMode = true
        JackpotRising.sharedInstance.apiMode = .production
        
        //        let contest = JackpotRising.sharedInstance.getContestStatus()
        //        print(contest.rawValue)
        ////
        uxTxtScore.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startSDKAction(_ sender: AnyObject) {
        JackpotRising.sharedInstance.showSDK()
    }
    
    @IBAction func submitScore(_ sender: AnyObject) {
        if JackpotRising.sharedInstance.isContestRunning() {
            if let txt = uxTxtScore.text{
                JackpotRising.sharedInstance.submitScore(Double(txt) ?? 0)
            }
        }
    }
    
    @IBAction func adWatched(_ sender: Any) {
        JackpotRising.sharedInstance.contestAdWatched(true)
    }
    
    //SDK delegate
    
    func contestData(_ data: [String: Any]) {
        print(data)
    }
    
    func locationFecthStatus(_ status: Bool) {
        print(status)
    }
    
    func initialPopupCancelled(){
        print("SDK cancelled")
    }
    
    func sdkClosed() {
        print("SDK closed")
    }
    
    func sdkFailedToInitialize(_ message: String) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func playContest(_ adStatus: Bool) {
        print("play contest \(adStatus)")
        if adStatus {
            if let url = NSURL(string: "https://cinelerra-cv.org/footage/MVI_3572.AVI"){
                playVideo(url: url)
            }
        }
    }
    func playVideo(url: NSURL){
        let player = AVPlayer(url: url as URL)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        playerController.player = player

       playerController.modalPresentationStyle = .overCurrentContext
        present(playerController, animated: true) {
            player.play()
        }
    }
    
   @objc func playerDidFinishPlaying(note: NSNotification) {
        playerController.view.removeFromSuperview()
        playerController.removeFromParentViewController()
        playerController.dismiss(animated: true, completion: nil)
        JackpotRising.sharedInstance.contestAdWatched(true)
    }
}

