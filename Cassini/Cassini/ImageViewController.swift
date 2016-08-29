//
//  ImageViewController.swift
//  Cassini
//


import UIKit

class ImageViewController: UIViewController {
    
    var imageURL: URL? {
        didSet {
            image = nil
            fetchImage()
        }
    }
    
    private func fetchImage() {
        guard let url = imageURL else { return }
        do {
            let imageData = try Data(contentsOf: url)
            image = UIImage(data: imageData)
        } catch let error {
            print("\(error)")
        }
        
    }
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        imageURL = DemoURL.NASAImageNamed(imageName: "Cassini")
    }

}
