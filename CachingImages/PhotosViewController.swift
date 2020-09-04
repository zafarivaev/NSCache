//
//  ViewController.swift
//  CachingImages
//
//  Created by Zafar on 9/3/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

class PhotosViewController: UICollectionViewController {
    
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        
        self.collectionView.backgroundColor = .white
        self.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    // MARK: - Image Loading
    private func loadImage(completion: @escaping (UIImage?) -> ()) {
        utilityQueue.async {
            let url = URL(string: "https://picsum.photos/200")!
            
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    // MARK: - UICollectionView Data Source
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCollectionViewCell
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? PhotoCollectionViewCell else { return }
        
        let itemNumber = NSNumber(value: indexPath.item)
        
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            print("Using a cached image for item: \(itemNumber)")
            cell.imageView.image = cachedImage
        } else {
            self.loadImage { [weak self] (image) in
                guard let self = self, let image = image else { return }
                
                cell.imageView.image = image
                
                self.cache.setObject(image, forKey: itemNumber)
            }
        }
    }
    
}

