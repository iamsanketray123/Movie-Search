//
//  Loader.swift
//  Loco
//
//  Created by Sanket  Ray on 16/10/22.
//

import UIKit

public class Loader {

    public static let shared = Loader()
    var blurImg = UIImageView()
    var indicator = UIActivityIndicatorView()

    private init() {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
        indicator.style = .medium
        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color = .systemRed
    }

    func show(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            viewController.view.addSubview(self.blurImg)
            viewController.view.addSubview(self.indicator)
        }
    }

    func hide() {
        DispatchQueue.main.async {
            self.blurImg.removeFromSuperview()
            self.indicator.removeFromSuperview()
        }
    }
}
