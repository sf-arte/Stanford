//
//  BlinkingFaceViewController.swift
//  FaceIt
//

import UIKit

class BlinkingFaceViewController: FaceViewController {
    
    var blinking: Bool = false {
        didSet {
            startBlink()
        }
    }
    
    private struct BlinkRate {
        static let ClosedDuration = 0.4
        static let OpenDuration = 2.5
    }
    
    func startBlink() {
        if blinking {
            faceView.eyesOpen = false
            Timer.scheduledTimer(timeInterval: BlinkRate.ClosedDuration, target: self, selector: #selector(BlinkingFaceViewController.endBlink), userInfo: nil, repeats: false)
        }
    }
    
    func endBlink() {
        let date = NSDate()
        
        print("endBlink() \(date.timeIntervalSince1970)")
            faceView.eyesOpen = true
            Timer.scheduledTimer(timeInterval: BlinkRate.OpenDuration, target: self, selector: #selector(BlinkingFaceViewController.startBlink), userInfo: nil, repeats: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blinking = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        blinking = false
    }
    
}
