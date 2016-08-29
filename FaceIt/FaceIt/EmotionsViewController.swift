//
//  EmotionsViewController.swift
//  FaceIt
//

import UIKit

class EmotionsViewController: UIViewController {
    
    private let emotionalFaces: Dictionary<String, FacialExpression> = [
        "angry" : FacialExpression(eyes: .closed, eyeBrows: .furrowed, mouth: .frown),
        "happy" : FacialExpression(eyes: .open, eyeBrows: .normal, mouth: .smile),
        "worried" : FacialExpression(eyes: .open, eyeBrows: .relaxed, mouth: .smirk),
        "mischievious" : FacialExpression(eyes: .open, eyeBrows: .furrowed, mouth: .grin)
    ]

    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationvc = segue.destinationViewController
        guard let navcon = destinationvc as? UINavigationController else { return }
        guard let facevc = navcon.visibleViewController as? FaceViewController else { return }
      
        if let identifier = segue.identifier {
           if let expression = emotionalFaces[identifier] {
               facevc.expression = expression
                if let sendingButton = sender as? UIButton {
                    facevc.navigationItem.title = sendingButton.currentTitle
                }
            }
        }
    }

    let instance = getEmotionsMVCinstanceCount()
}
