//
//  PhotoCollectionViewCell.swift
//  GlacierScenics
//
//  Created by GILL/Samsung on 16/01/19.. Updated 8/11/18.
//  Copyright © 2018 Gill. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    var photourl: String = ""
    var name: String = ""
    
    weak var photosManager: PhotosManager?

    func configure(with photourl: String, name: String, photosManager: PhotosManager) {
        self.photourl = photourl
        self.name = name
        self.photosManager = photosManager
        reset()
        loadImage()
    }

    func reset() {
        imageView.image = nil
        captionLabel.isHidden = true
    }

    func loadImage() {
        if let image = photosManager?.cachedImage(for: self.photourl) {
            populate(with: image)
            return
        }
        downloadImage()
    }

    func downloadImage() {
        loadingIndicator.startAnimating()
        photosManager?.retrieveImage(for: self.photourl) { image in
            self.populate(with: image!)
        }
    }

    func populate(with image: UIImage) {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.imageView.image = image
            self.captionLabel.text = self.name
            self.captionLabel.isHidden = false
        }
    }

}
