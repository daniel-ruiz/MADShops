//
//  ViewController.swift
//  MADShops
//
//  Created by Daniel Ruiz on 14/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetViewState()
        performCaching()
    }

    func resetViewState() {
        activitySpinner.isHidden = true
        startButton.isHidden = true
    }
    
    func performCaching() {
        if !CacheManager.shared.alreadyCached {
            
            activitySpinner.isHidden = false
            activitySpinner.startAnimating()
            
            CacheManager.shared.cacheShops {
                self.activitySpinner.stopAnimating()
                self.activitySpinner.isHidden = true
                self.startButton.isHidden = false
            }
            
        } else {
            self.startButton.isHidden = false
        }
    }

}

