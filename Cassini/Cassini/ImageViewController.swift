//
//  ImageViewController.swift
//  Cassini
//


import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    private func fetchImage() {
        guard let url = imageURL else { return }
        spinner?.startAnimating()
        let queue = DispatchQueue.global(attributes: .qosUserInitiated)
        queue.async {
            var contentsOfURL : Data? = nil
            do {
                contentsOfURL = try Data(contentsOf: url)
            } catch let error {
                print("\(error)")
            }
            let mainQueue = DispatchQueue.main
            mainQueue.async {
                if url == self.imageURL {
                    if let imageData = contentsOfURL {
                        self.image = UIImage(data: imageData)
                    } else {
                        self.spinner?.stopAnimating()
                    }
                } else {
                    print("ignored data returned from url \(url)")
                }
            }
        }
        
    }
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private var imageView = UIImageView()
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }

}
