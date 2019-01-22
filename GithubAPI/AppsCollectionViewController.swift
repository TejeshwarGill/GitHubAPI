//
//  AppsCollectionViewController.swift
//
//  Created by GILL/Samsung on 16/01/19..
//  Copyright © 2018 Gill. All rights reserved.
//

import UIKit

class AppsCollectionViewController: UICollectionViewController {

    var viewModel: ViewModel = ViewModel()
    let photoManager: PhotosManager = PhotosManager()
    private let photoCellIdentifier = "PhotoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.apiClient = APIClient()
        self.fetchLatestData(with: "")
    }

    func fetchLatestData(with query:String){
        viewModel.getApps(query) {
            self.collectionView.reloadData()
        }
    }
    
    func registerCollectionViewCells() {
        let nib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: photoCellIdentifier)
    }
    
    // MARK: - Collection view data source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return viewModel.numberOfItemsToDisplay(in: section)
    }
  
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        let url:String = viewModel.appImageDisplay(for: indexPath)
        
        cell.configure(with: url, name: viewModel.appTitleToDisplay(for: indexPath) + "\n" + viewModel.appDescriptionToDisplay(for: indexPath), photosManager: photoManager)

        let image = photoManager.cachedImage(for: url)
        if  image != nil {
            cell.imageView?.image = image
        }else{
            photoManager.retrieveImage(for: url) { (img) in
                DispatchQueue.main.async {
                    cell.imageView?.image = img
                }
            }
        }
        return cell
    }
}

//MARK: - CollectionView Flow Layout

extension AppsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewSize = view.bounds.size
        let spacing: CGFloat = 0.5
        let width = (viewSize.width / 2) - spacing
        let height = (viewSize.width / 3) - spacing
        return CGSize(width: width/2, height: height)
        }
}
