//
//  RecordingViewController.swift
//  Nume
//
//  Created by Daniel Hsu on 4/24/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//
import UIKit
import AVFoundation


class RecordingViewController: UIViewController, AVAudioRecorderDelegate {
    
    let audioURL : NSURL
    let audioSession : AVAudioSession
    let audioRecorder : AVAudioRecorder
    var audioPlayer : AVAudioPlayer!
    
    required init(coder aDecoder: NSCoder) {
        
        let documentDirectoryString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        self.audioURL = NSURL(string: documentDirectoryString + "/audiofile.m4a")!
        
        var error : NSError?
        
        // TODO: Vet the appropriateness of these settings
        let settings = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVLinearPCMBitDepthKey: 16,
            AVLinearPCMIsBigEndianKey: 0,
            AVLinearPCMIsFloatKey: 0,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100
        ]
        
        self.audioSession = AVAudioSession.sharedInstance()
        self.audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        
        if let error = error {
            println(error)
        }
        
        self.audioSession.overrideOutputAudioPort(.Speaker, error: &error)
        
        if let error = error {
            println(error)
        }
        
        self.audioRecorder = AVAudioRecorder(URL: self.audioURL, settings: settings, error: &error)
        
        if let error = error {
            println(error)
        }
        
        super.init(coder: aDecoder)
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        self.audioRecorder.delegate = self
        if self.audioRecorder.recordForDuration(20) {
            // Succeeded
            println("recording starting!")
        } else {
            println("failed to record!")
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        println("finished!")
        
        var error : NSError?
    }
}