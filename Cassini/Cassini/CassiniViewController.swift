//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Suita Fujino on 2016/08/29.
//  Copyright © 2016年 ARTE Co., Ltd. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
    private struct Storyboard {
        static let ShowImageSegue = "Show Image"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.ShowImageSegue {
            guard let ivc = segue.destinationViewController.contentViewController as? ImageViewController else { return }
            guard let imageName = (sender as? UIButton)?.currentTitle else { return }
            ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
            ivc.title = imageName
        }
    }

}

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
