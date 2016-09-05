//
//  CassiniViewController.swift
//  Cassini
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {
    private struct Storyboard {
        static let ShowImageSegue = "Show Image"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowImageSegue {
            guard let ivc = segue.destination.contentViewController as? ImageViewController else { return }
            guard let imageName = (sender as? UIButton)?.currentTitle else { return }
            ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
            ivc.title = imageName
        }
    }
    
    
    @IBAction func showImage(_ sender: UIButton) {
        if let ivc = splitViewController?.viewControllers.last?.contentViewController as? ImageViewController {
            guard let imageName = sender.currentTitle else { return }
            ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
            ivc.title = imageName
        } else {
            performSegue(withIdentifier: Storyboard.ShowImageSegue, sender: sender)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contentViewController == self {
            if let ivc = secondaryViewController.contentViewController as? ImageViewController, ivc.imageURL == nil {
                return true
            }
        }
        return false
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
