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
        guard let imageData = Data(contentsOfURL: url) else { return }
        
        image = UIImage(data: imageData)
    }
    
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }

}
