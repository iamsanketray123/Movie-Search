//
//  BaseViewController.swift
//  Loco
//
//  Created by Sanket  Ray on 16/10/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoader() {
        Loader.shared.show(self)
    }
    
    func hideLoader() {
        Loader.shared.hide()
    }
}
