//
//  ViewController.swift
//  SwiftMicrophoneDemo
//
//  Created by Rohit Swamy on 11/23/14.
//  Copyright (c) 2014 Bicro. All rights reserved.
//

import UIKit
import CoreAudio
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var recorder: AVAudioRecorder
        
        var audioSession: AVAudioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioSession.setActive(true, error: nil)
        
        var url:NSURL = NSURL.fileURLWithPath("/dev/null")!
        
        
        var settings = Dictionary<String, NSNumber>()
        settings[AVSampleRateKey] = 44100.0
        settings[AVFormatIDKey] = kAudioFormatAppleLossless
        settings[AVNumberOfChannelsKey] = 1
        settings[AVEncoderAudioQualityKey] = 0x7F //max quality hex
        
        recorder = AVAudioRecorder(URL: url, settings: settings, error: nil)
        
        recorder.prepareToRecord()
        recorder.meteringEnabled = true
        recorder.record()

        var levelTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerCallBack:", userInfo: recorder, repeats: true)

    }
    
    func timerCallBack(timer:NSTimer){
        var recorder: AVAudioRecorder = timer.userInfo as AVAudioRecorder
        recorder.updateMeters()
        var avgPower: Float = 160+recorder.averagePowerForChannel(0)
        println(avgPower)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

