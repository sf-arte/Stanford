//
//  NamedBezierPathView.swift
//  DropIt
//
//  Created by Suita Fujino on 2016/09/14.
//  Copyright © 2016年 ARTE Co., Ltd. All rights reserved.
//

import UIKit

class NamedBezierPathView: UIView {
    
    var bezierPaths = [String: UIBezierPath]() { didSet { setNeedsDisplay() } }
   
    override func draw(_ rect: CGRect) {
        for (_, path) in bezierPaths {
            path.stroke()
        }
    }

}
