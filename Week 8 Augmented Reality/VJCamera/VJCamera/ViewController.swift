//
//  ViewController.swift
//  VJCamera
//
//  Created by Chuchu Jiang on 4/3/19.
//  Copyright © 2019 adajiang. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation
//import Vision

import CoreAudio
import CoreAudioKit
import Foundation
import AVKit


// Sample filters and settings.
// For more resournces/examples:
//   https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html
//   https://developer.apple.com/library/content/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html
//   https://github.com/FlexMonkey/Filterpedia

let NoFilter = "No Filter"
let NoFilterFilter: CIFilter? = nil

var inputWidthCircular = 6
let CircularScreen = "CircularScreen"
var CircularScreenFilter = CIFilter(name: "CICircularScreen", parameters: ["inputWidth" : 6, "inputSharpness": 0.7])

var inputWidthOpTile = 40   //20- 200
let OpTile = "OpTile"
let OpTileFilter = CIFilter(name: "CIOpTile", parameters: ["inputScale": 2.80, "inputWidth":40])

var inputWidthSixfold = 100
let SixfoldReflectedTile = "SixfoldReflectedTile"
let SixfoldReflectedTileFilter = CIFilter(name: "CISixfoldReflectedTile", parameters: ["inputWidth" : 100])

var inputAmount = 20
let ZoomBlur = "ZoomBlur"
let ZoomBlurFilter = CIFilter(name: "CIZoomBlur", parameters: ["inputAmount" : 20])

var inputScale = 0.5
let BumpDistortionLinear = "BumpDistortionLinear"
let BumpDistortionLinearFilter = CIFilter(name: "CIBumpDistortionLinear", parameters: ["inputRadius": 400, "inputScale": 0.5])

let Filters = [
    NoFilter: NoFilterFilter,
    CircularScreen: CircularScreenFilter,
    OpTile: OpTileFilter,
    SixfoldReflectedTile: SixfoldReflectedTileFilter,
    ZoomBlur: ZoomBlurFilter,
    BumpDistortionLinear: BumpDistortionLinearFilter,
]

let FilterNames = [String](Filters.keys)


class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, AVAudioRecorderDelegate {
    
    // Real time camera capture session.
    var captureSession = AVCaptureSession()
    
    // References to camera devices.
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    // Context for using Core Image filters.
    let context = CIContext()
    
    // Track device orientation changes.
    var orientation: AVCaptureVideoOrientation = .portrait
    
    // Use location manager to get heading.
    let locationManager = CLLocationManager()
    
    // Reference to current filter.
    var currentFilter: CIFilter?
    var filterIndex = 0

    //recorder for audio
    var recorder: AVAudioRecorder!

    // Image view for filtered image.
    
    @IBOutlet weak var filteredImage: UIImageView!
    //    var filteredImage: UIImageView?

    
    
    // Outlets to buttons.
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

//        filteredImage.frame = UIScreen.main.bounds
//        filteredImage.frame = self.view.bounds
//        filteredImage.contentMode = .scaleAspectFit
//        filteredImage.clipsToBounds = true

        // Camera device setup.
        setupDevice()
        setupInputOutput()
        
        // Recorder setup
        initRecorder()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        recorder.updateMeters()
//        let level = recorder.averagePower(forChannel: 0)
//        print("level:\(level)")
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Detect device orientation changes.
        orientation = AVCaptureVideoOrientation(rawValue: UIApplication.shared.statusBarOrientation.rawValue)!
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Toggle front/back camera
    @IBAction func flipCameraButton(_ sender: UIButton) {
        switchCameraInput()
        // Set button title.
        let buttonTitle = currentCamera == frontCamera ? "Front Camera" : "Back Camera"
        cameraButton.setTitle(buttonTitle, for: .normal)
    }
    
    
    // Cycle through filters.
    @IBAction func changeFilterButton(_ sender: UIButton) {
        // Increment to next index.
        filterIndex = filterIndex + 1 == Filters.count ? 0 : filterIndex + 1
        
        // Set button ui name.
        let filterName = FilterNames[filterIndex]
        filterButton.setTitle(filterName, for: .normal)
        
        // Set current filter.
        currentFilter =  Filters[filterName]!
    }
    
    
    // AVCaptureVideoDataOutputSampleBufferDelegate method.
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        
        // Set correct device orientation.
        connection.videoOrientation = orientation
        
        // Get pixel buffer.
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        var cameraImage = CIImage(cvImageBuffer: pixelBuffer!)
        
        // Mirror camera image if using front camera.
        if currentCamera == frontCamera {
            cameraImage = cameraImage.oriented(.upMirrored)
        }
        
        // Get the filtered image if a currentFilter is set.
        var filteredImage: UIImage!
        if currentFilter == nil {
            filteredImage =  UIImage(ciImage: cameraImage)
        } else {
            self.currentFilter!.setValue(cameraImage, forKey: kCIInputImageKey)
            let cgImage = self.context.createCGImage(self.currentFilter!.outputImage!, from: cameraImage.extent)!
            filteredImage = UIImage(cgImage: cgImage)
        }
        
        // Set image view outlet with filtered image.
        DispatchQueue.main.async {
            self.filteredImage.image = filteredImage
        }
        
        //get level from recorder
        recorder.updateMeters()
        let level = recorder.averagePower(forChannel: 0)
//        print("level:\(level)")
//        let peakLevel = recorder.peakPower(forChannel: 0)
//        print("peakLevel:\(peakLevel*100)")
        if self.currentFilter == Filters["OpTile"] {
            if level < -40 {
                inputWidthOpTile = 20
            } else {
                inputWidthOpTile = Int(myMap(n: level, start1: -40, stop1: 0, start2: 20, stop2: 200))
            }
            self.currentFilter!.setValue(inputWidthOpTile, forKey: kCIInputWidthKey)
        }
        
        if self.currentFilter == Filters["CircularScreen"] {
            self.currentFilter!.setValue(CIVector(x:filteredImage.size.width/2, y: filteredImage.size.height/2), forKey: kCIInputCenterKey)
            if level < -20 {
                inputWidthCircular = 6
            }else {
                inputWidthCircular = Int(myMap(n: level, start1: -20, stop1: 0, start2: 6, stop2: 100))
            }
            self.currentFilter!.setValue(inputWidthCircular, forKey: kCIInputWidthKey)
        }
        
        if self.currentFilter == Filters["SixfoldReflectedTile"] {
            self.currentFilter!.setValue(CIVector(x:filteredImage.size.width/2, y: filteredImage.size.height/2), forKey: kCIInputCenterKey)
            if level < -30 {
                inputWidthSixfold = 100
            }else {
                inputWidthSixfold = Int(myMap(n: level, start1: -30, stop1: 0, start2: 100, stop2: 500))
            }
            self.currentFilter!.setValue(inputWidthSixfold, forKey: kCIInputWidthKey)
        }
        
        if self.currentFilter == Filters["ZoomBlur"] {
            self.currentFilter!.setValue(CIVector(x:filteredImage.size.width/2, y: filteredImage.size.height/2), forKey: kCIInputCenterKey)
            if level < -20 {
                inputAmount = 5
            } else {
                inputAmount = Int(myMap(n: level, start1: -20, stop1: 0, start2: 5, stop2: 30))
            }
            self.currentFilter!.setValue(inputAmount, forKey: kCIInputAmountKey)
        }
        
        if self.currentFilter == Filters["BumpDistortionLinear"] {
            self.currentFilter!.setValue(CIVector(x:filteredImage.size.width/2, y: filteredImage.size.height/2), forKey: kCIInputCenterKey)
            if level < -20 {
                inputScale = 0.5
            } else {
                inputScale = Double(myMap(n: level, start1: -20, stop1: 0, start2: 0.5, stop2: 7))
            }
            self.currentFilter!.setValue(inputScale, forKey: kCIInputScaleKey)
        }
        

    }
    
    
    //recorder
    func initRecorder() {
        let documents = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        let url = documents.appendingPathComponent("record.caf")
        
        let recordSettings: [String: Any] = [
            AVFormatIDKey:              kAudioFormatAppleIMA4,
            AVSampleRateKey:            44100.0,
            AVNumberOfChannelsKey:      2,
            AVEncoderBitRateKey:        12800,
            AVLinearPCMBitDepthKey:     16,
            AVEncoderAudioQualityKey:   AVAudioQuality.max.rawValue
        ]
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            try audioSession.setActive(true)
            try recorder = AVAudioRecorder(url:url, settings: recordSettings)
            
        } catch {
            return
        }
        
        recorder.prepareToRecord()
        recorder.isMeteringEnabled = true
        recorder.record()
    }
    
    func myMap(n: Float, start1: Float, stop1: Float, start2: Float, stop2: Float) -> Float {
        let a = n - start1
        let b = stop1 - start1
        let c = a/b
        let d = stop2 - start2
        let e = c * d
        let f = e + start2
//        return ( (n-start1) / (stop1-start1) ) * (stop2-start2) + start2;
        return f
    }
}



///////////////////////////////////////////////////////////////
extension CGRect {
    func scaled(to size: CGSize) -> CGRect {
        return CGRect(
            x: self.origin.x * size.width,
            y: self.origin.y * size.height,
            width: self.size.width * size.width,
            height: self.size.height * size.height
        )
    }
}



///////////////////////////////////////////////////////////////
// Helper methods to setup camera capture view.
extension ViewController {
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],
                                                                      mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            }
            else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        
        currentCamera = backCamera
    }
    
    func setupInputOutput() {
        do {
            setupCorrectFramerate(currentCamera: currentCamera!)
            
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.sessionPreset = AVCaptureSession.Preset.hd1280x720
            
            if captureSession.canAddInput(captureDeviceInput) {
                captureSession.addInput(captureDeviceInput)
            }
            
            let videoOutput = AVCaptureVideoDataOutput()
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer delegate", attributes: []))
            
            if captureSession.canAddOutput(videoOutput) {
                captureSession.addOutput(videoOutput)
            }
            
            captureSession.startRunning()
        } catch {
            print(error)
        }
    }
    
    func setupCorrectFramerate(currentCamera: AVCaptureDevice) {
        for vFormat in currentCamera.formats {
            var ranges = vFormat.videoSupportedFrameRateRanges as [AVFrameRateRange]
            let frameRates = ranges[0]
            do {
                //set to 240fps - available types are: 30, 60, 120 and 240 and custom
                // lower framerates cause major stuttering
                if frameRates.maxFrameRate == 240 {
                    try currentCamera.lockForConfiguration()
                    currentCamera.activeFormat = vFormat as AVCaptureDevice.Format
                    //for custom framerate set min max activeVideoFrameDuration to whatever you like, e.g. 1 and 180
                    currentCamera.activeVideoMinFrameDuration = frameRates.minFrameDuration
                    currentCamera.activeVideoMaxFrameDuration = frameRates.maxFrameDuration
                }
            }
            catch {
                print("Could not set active format")
                print(error)
            }
        }
    }
    
    func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let discovery = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],
                                                         mediaType: AVMediaType.video,
                                                         position: .unspecified) as AVCaptureDevice.DiscoverySession
        for device in discovery.devices as [AVCaptureDevice] {
            if device.position == position {
                return device
            }
        }
        
        return nil
    }
    
    func switchCameraInput() {
        self.captureSession.beginConfiguration()
        
        var existingConnection:AVCaptureDeviceInput!
        
        for connection in self.captureSession.inputs {
            let input = connection as! AVCaptureDeviceInput
            if input.device.hasMediaType(AVMediaType.video) {
                existingConnection = input
            }
            
        }
        
        self.captureSession.removeInput(existingConnection)
        
        var newCamera:AVCaptureDevice!
        if let oldCamera = existingConnection {
            newCamera = oldCamera.device.position == .back ? frontCamera : backCamera
            currentCamera = newCamera
        }
        
        var newInput: AVCaptureDeviceInput!
        
        do {
            newInput = try AVCaptureDeviceInput(device: newCamera)
            self.captureSession.addInput(newInput)
        } catch {
            print(error)
        }
        
        self.captureSession.commitConfiguration()
    }
}
