//
//  BaseViewController.swift
//  Loco
//
//  Created by Sanket  Ray on 16/10/22.
//

import UIKit

/// The base class for all View Controllers
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
    
    func handleError(_ error: APIError) {
        
        DispatchQueue.main.async { [weak self] in
            
            // Create Alert
            let alertController = UIAlertController(title: "Oops!", message: error.description, preferredStyle: .alert)
            
            // Create Action
            let okAction = UIAlertAction(title: "Okay", style: .default)
            
            // Add Action To Alert
            alertController.addAction(okAction)
            
            // Present Alert Controller
            self?.present(alertController, animated: true)
        }
    }
}
