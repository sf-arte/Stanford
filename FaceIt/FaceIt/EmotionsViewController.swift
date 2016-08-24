//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Suita Fujino on 2016/08/24.
//  Copyright © 2016年 ARTE Co., Ltd. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    private let emotionalFaces: Dictionary<String, FacialExpression> = [
        "angry" : FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
        "happy" : FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
        "worried" : FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
        "mischievious" : FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)
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

}
