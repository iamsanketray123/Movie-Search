//
//  Loader.swift
//  Loco
//
//  Created by Sanket  Ray on 16/10/22.
//

import UIKit

public class Loader {
    
    // Singleton
    public static let shared = Loader()
    var blurImage = UIImageView()
    var indicator = UIActivityIndicatorView()
    
    private init() {
        
        // Set Blur Image Properties
        blurImage.frame = UIScreen.main.bounds
        blurImage.backgroundColor = UIColor.black
        blurImage.isUserInteractionEnabled = true
        blurImage.alpha = 0.5
        
        // Set Indicator Properties
        indicator.style = .medium
        indicator.center = blurImage.center
        indicator.startAnimating()
        indicator.color = .systemRed
    }
    
    public func show(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            viewController.view.addSubview(self.blurImage)
            viewController.view.addSubview(self.indicator)
        }
    }
    
    public func hide() {
        DispatchQueue.main.async {
            self.blurImage.removeFromSuperview()
            self.indicator.removeFromSuperview()
        }
    }
}
