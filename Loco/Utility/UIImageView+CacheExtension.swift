//
//  UIImageView+CacheExtension.swift
//  Loco
//
//  Created by Sanket  Ray on 16/10/22.
//

import UIKit


// Cache Layer
let imageCache = NSCache<AnyObject, AnyObject>()


// MARK: - UIImageView extension
extension UIImageView {
    
    // This method will load the image for the image view; either by fetching from Cache or by making an API call
    func loadImage(urlSting: String) {
        
        // Validation
        guard let url = URL(string: urlSting) else { return }
        
        // Set Image as Nil
        image = nil
        
        // Check If Image Found In Cache
        if let imageFromCache = imageCache.object(forKey: urlSting as AnyObject) {
            
            // Set Cached Image
            image = imageFromCache as? UIImage
            return
        }
        
        // Proceed With Download
        APIService.downloadImage(url: url) { [weak self] result in
            
            // Validation
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                
                // Get Image
                guard let imageToCache = UIImage(data: data) else { return }
                
                // Save Image To Cache
                imageCache.setObject(imageToCache, forKey: urlSting as AnyObject)
                
                DispatchQueue.main.async {
                    
                    // Set Image
                    self.image = UIImage(data: data)
                }
            case .failure(_):
                
                DispatchQueue.main.async {
                    
                    // Set Default Image
                    self.image = UIImage(named: "noImage")
                }
            }
        }
    }
}

