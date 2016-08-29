//
//  ViewController.swift
//  FaceIt
//

import UIKit

class FaceViewController: UIViewController {
    var expression = FacialExpression(eyes: .open, eyeBrows: .normal, mouth: .smile) {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(recognizer:))
            ))
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.decreaseHappiness)
            )
            sadderSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            faceView.addGestureRecognizer(UIRotationGestureRecognizer(
                target: self, action: #selector(FaceViewController.changeBrows(recognizer:))
            ))
            
            updateUI()
        }
    }
    
    @IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            switch expression.eyes {
            case .open: expression.eyes = .closed
            case .closed: expression.eyes = .open
            case .squinting: break
            }
        }
        
    }
    
    func changeBrows(recognizer: UIRotationGestureRecognizer) {
        switch recognizer.state {
        case .changed,.ended:
            if recognizer.rotation > CGFloat(M_PI/4) {
                expression.eyeBrows = expression.eyeBrows.moreRelaxedBrow()
                recognizer.rotation = 0.0
            } else if recognizer.rotation < -CGFloat(M_PI/4) {
                expression.eyeBrows = expression.eyeBrows.moreFurrowedBrow()
                recognizer.rotation = 0.0
            }
        default:
            break
        }
    }
    
    func increaseHappiness()
    {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappiness()
    {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    private var mouthCurvatures = [FacialExpression.Mouth.frown: -1.0, .grin: 0.5, .smile: 1.0, .smirk: -0.5, .neutral: 0.0]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.relaxed: 0.5, .furrowed: -0.5, .normal: 0.0]
    
    private func updateUI() {
        if faceView != nil {
            switch expression.eyes {
            case .open: faceView.eyesOpen = true
            case .closed: faceView.eyesOpen = false
            case .squinting: faceView.eyesOpen = false
            }
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
            faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        }
    }
}

