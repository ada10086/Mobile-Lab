//
//  ViewController.swift
//  VoiceSoundEffect
//
//  Created by Chuchu Jiang on 4/10/19.
//  Copyright © 2019 adajiang. All rights reserved.
//

import UIKit
import Speech
import SwiftSiriWaveformView
import AVFoundation


class ViewController: UIViewController, SFSpeechRecognizerDelegate, AVAudioRecorderDelegate {
    
    var timer: Timer?
    var change: CGFloat = 0.01
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var recorder: AVAudioRecorder!
    var player: AVAudioPlayer?

    // View for audio wave form feedback.
    @IBOutlet weak var audioWaveView1: SwiftSiriWaveformView!
    @IBOutlet weak var detectedTextLabel1: UILabel!
    @IBOutlet weak var gifView: UIImageView!
    
    var mostRecentlyProcessedSegmentDuration: TimeInterval = 0
    
    var lastBestString = ""
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.requestSpeechAuthorization()
        
        self.audioWaveView1.density = 1.0
        self.audioWaveView1.waveColor = UIColor.white
        
        if self.recorder != nil {
            return
        }
        
        let url: NSURL = NSURL(fileURLWithPath: "/dev/null")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            self.recorder = try AVAudioRecorder(url: url as URL, settings: settings )
            self.recorder.delegate = self
            self.recorder.isMeteringEnabled = true
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.record)))
            
            self.recorder.record()
            
            timer = Timer.scheduledTimer(timeInterval: 0.009, target: self, selector: #selector(refreshAudioView(_:)), userInfo: nil, repeats: true)
        } catch {
            print("Fail to record.")
        }
    }
    
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    print("authorized")
                    self.recordAndRecognizeSpeech()
                case .denied:
                    print("denied")
                case .restricted:
                    print("restricted")
                case .notDetermined:
                    print("notDetermined")
                @unknown default:
                    return
                }
            }
        }
    }
    
    func recordAndRecognizeSpeech() {
        let node = audioEngine.inputNode
        
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            self.sendAlert(message: "There has been an audio engine error.")
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            self.sendAlert(message: "Speech recognition is not supported for your current locale.")
            return
        }
        if !myRecognizer.isAvailable {
            self.sendAlert(message: "Speech recognition is not currently available. Check back at a later time.")
            // Recognizer is not available right now
            return
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                
                let bestString = result.bestTranscription.formattedString
                

                self.detectedTextLabel1.text = bestString
                print("bestString: \(bestString)")
                
                if let lastSegment = result.bestTranscription.segments.last,
                    lastSegment.duration > self.mostRecentlyProcessedSegmentDuration {
                    self.mostRecentlyProcessedSegmentDuration = lastSegment.duration
                    
                    /////////////////////////////////////////////////////////////////////
                    // Get last spoken word.
                    // Process request here.
                    
                    let string = lastSegment.substring
                    print(lastSegment.duration)
                    if string.lowercased() == "me" && bestString.lowercased().contains("excuse me") {
                        self.playSoundMP3(filename: "excuseme")
                        self.gifView.loadGif(name:"excuseme")
                    } else if string.lowercased() == "no" && bestString.lowercased().contains("oh no") {
                        self.playSoundMP3(filename: "fightme")
                        self.gifView.loadGif(name:"fightme")
                    } else if string.lowercased() == "fine" {
                        self.playSoundMP3(filename: "fine")
                        self.gifView.loadGif(name:"fine")
                    } else if string.lowercased() == "ha" && bestString.lowercased().contains("ha ha") {
                        self.playSoundMP3(filename: "haha")
                        self.gifView.loadGif(name:"haha")
                    } else if string.lowercased() == "god" && bestString.lowercased().contains("oh my god") {
                        self.playSoundMP3(filename: "omg")
                        self.gifView.loadGif(name:"omg")
                    } else if string.lowercased() == "up" && bestString.lowercased().contains("hurry up") {
                        self.playSoundMP3(filename: "hurry")
                        self.gifView.loadGif(name:"hurry")
                    } else if string.lowercased() == "sorry" && bestString.lowercased().contains("so sorry")  {
                        self.playSoundMP3(filename: "Ohno")
                        self.gifView.loadGif(name:"ohno")
                    } else if string.lowercased() == "ok" {
                        self.playSoundMP3(filename: "ok")
                        self.gifView.loadGif(name:"ok")
                    } else if string.lowercased() == "00" {
                        self.playSoundMP3(filename: "oops")
                        self.gifView.loadGif(name:"oops")
                    } else if string.lowercased() == "start" {
                        self.playSoundMP3(filename: "start")
                        self.gifView.loadGif(name:"start")
                    } else if string.lowercased() == "you" && bestString.lowercased().contains("thank you"){
                        self.playSoundMP3(filename: "thankyou")
                        self.gifView.loadGif(name:"thankyou")
                    } else if string.lowercased() == "yay" {
                        self.playSoundMP3(filename: "yay")
                        self.gifView.loadGif(name:"yay")
                    }
                    
                    if result.isFinal{
                        self.requestSpeechAuthorization()
                    }
                    /////////////////////////////////////////////////////////////////////
                }
                
            } else if let error = error {
                self.sendAlert(message: "There has been a speech recognition error.")
                print(error)
            }
        })
    }
    
    func sendAlert(message: String) {
        let alert = UIAlertController(title: "Speech Recognizer Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc internal func refreshAudioView(_: Timer) {
        // Simply set the amplitude to whatever you need and the view will update itself.
        self.audioWaveView1.amplitude = 0.5
        
        recorder.updateMeters()
        
        let normalizedValue:CGFloat = pow(10, CGFloat(recorder.averagePower(forChannel: 0))/20)
        self.audioWaveView1.amplitude = normalizedValue
    }
    
    // Play a mp3 sound file.
    func playSoundMP3(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)), mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
    return input.rawValue
}


