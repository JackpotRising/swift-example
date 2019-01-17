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
        
        //dunk jams
               //staging
    //JackpotRising.sharedInstance.initWithClientCredentials("QCWOFIONDLJLSQEKZOOEXVTDTLZEJY7XLDTHRE4OBC7I3NQ6LJ2EN6JW",clientSecret: "T2GIH77MDOWCXZZPVYUKWWOBFWPMNUHYKSVQEUPQDE43ARBOQ7TQJ6OG")
       //production
        JackpotRising.sharedInstance.initWithClientCredentials("RS7VTQPI7V6BG5ANSTX42SH7KJQXPU37O4NUH2ZVJF5KJGV5WHCKTDUP",clientSecret: "FKSYNRSKY4Q76TD5OLJ6O6ZMIQTC46DQ4DBWNHUQ3CMEQFAFH4FNPLRA")
        
        
        
        
        //missiledodge
        //JackpotRising.sharedInstance.initWithClientCredentials("DUJZRGKGUDAEEJABAZWMDQBMVUNQHMLUMDIAXX4IFCCW22KNYHVLGC45",clientSecret: "VVDNDWBW4PSAYBJ4EX3BHIYOIBQQMRDUHACEBWXNHYPF5MTSJBDAUX6U")
       //staging credentials
        //JackpotRising.sharedInstance.initWithClientCredentials("W6OPDPNV6WRI3EWN2QANYSE64R4PA4YOD2XJLFNVHPTFLE6YRM7QLSC2",clientSecret: "U64OJTGODKK7SGXTN6QC5XKXZ4YZRM6ZZPZQR2KTIJRV4O5YNNZY3VT5")
    //  production credentials
        //JackpotRising.sharedInstance.initWithClientCredentials("M6Q6M7YKN2ZXZNMKWYO5OJEXSAFKZJRXVUHH44ZOODOCBOAODAJ7GIJX", clientSecret: "XNHNIDL52OF5D3IHUFJU2HNLF6FPB3UUUKMCQEC3EAJ5EYVWNZ47Z3NV")
      
           //    production credentials2
    //JackpotRising.sharedInstance.initWithClientCredentials("A7EQERDB5HKU3QFVTBTFGPX74XKOEHLV7PU2SM222WQ5TAXDJJQWDC2N", clientSecret: "VABWRCMD7QIA4CAIJDFUKOZ6UQPLVOPOAAOCZ5DWDIQDP7REC3U5JKLU")
        //JackpotRising.sharedInstance.initWithClientCredentials("A7EQERDB5HKU3QFVTBTFGPX74XKOEHLV7PU2SM222WQ5TAXDJJQWDC2N", clientSecret: "VABWRCMD7QIA4CAIJDFUKOZ6UQPLVOPOAAOCZ5DWDIQDP7REC3U5JKLU")
       //exp game staging
        //JackpotRising.sharedInstance.initWithClientCredentials("OJFAJNBVY2DDME6R5MBB7RNWJ7DLVC54L4WJETQVFOV5SC6GFPOOI5PS", clientSecret: "OWPINC3C4EIHX6WMEX67AYMCUYPOYG66TOEQIYATAWFIBLQPWV6BV4O7")
       
       //production
        //JackpotRising.sharedInstance.initWithClientCredentials("EB5GFDWFAYOQE45PEMTX6R54EKWFVH45ECKLCSCB7DI4TTYAAXQP6EUR", clientSecret: "ECB3ZT2YB2QOHZZ7M6IYK73RFAIAEQ32M3S32IQXEDS6OLJBNELXB4DW")
        
        
    //JackpotRising.sharedInstance.initWithClientCredentials("TXKWTZ3U63AESYOWI6JANFBEY33WAEZGYHV44DGMN6I5HD3B54XZHAE2", clientSecret: "IZD73XEECV5OSRSWDPJPJU4H53LLB6CBRLBMORXOKFPVTPORXAARNK6N")
        //missile dodge productiom
        //JackpotRising.sharedInstance.initWithClientCredentials("TXKWTZ3U63AESYOWI6JANFBEY33WAEZGYHV44DGMN6I5HD3B54XZHAE2", clientSecret: "IZD73XEECV5OSRSWDPJPJU4H53LLB6CBRLBMORXOKFPVTPORXAARNK6N")
        JackpotRising.sharedInstance.delegate = self
        JackpotRising.sharedInstance.pointingURL = .staging
        JackpotRising.sharedInstance.testMode = false
        JackpotRising.sharedInstance.apiMode = .production
        JackpotRising.sharedInstance.walkAwayMode = false
        JackpotRising.sharedInstance.walkAwayTime = 45
        
        
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
        //for test
        //JackpotRising.sharedInstance.setUniqueId("qwerty124")
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
    
    func contestStarted(_ data: [String : Any]) {
        print(data)
    }
    
    func fetchLocationStatus(_ status: Bool) {
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
    
    func playAd() {
        print("play contest ad")
        if let url = NSURL(string: "https://cinelerra-cv.org/footage/MVI_3572.AVI"){
            playVideo(url: url)
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
struct SharedData{
    /// singleton object for the struct
    static let sharedInstance = SharedData()
    var oneSignalAppId = "71c9fb11-9fdd-4343-b172-98922924a8c5"
}
