//
//  LoadingIndicatorViewExtension.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/27/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import UIKit

var loadingIndicator = UIActivityIndicatorView()

extension UIViewController {
    func showLoadingIndicator() {
        let halfScreenCoef: CGFloat = 2
        let loadingIndicatorWidthCoef: CGFloat = 2.5
        let loadingIndicatorHeightCoef: CGFloat = 5
        let loadingScreenCornerRadius: CGFloat = 25
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        loadingIndicator.frame =
            CGRect(x: 0,
                   y: 0,
                   width: screenWidth / loadingIndicatorWidthCoef,
                   height: screenHeight / loadingIndicatorHeightCoef)
        
        loadingIndicator.center =
            CGPoint(x: screenWidth / halfScreenCoef,
                    y: screenHeight / halfScreenCoef)
        
        loadingIndicator.layer.cornerRadius = loadingScreenCornerRadius
        loadingIndicator.activityIndicatorViewStyle = .whiteLarge
        loadingIndicator.backgroundColor = (UIColor (white: 0.3, alpha: 0.8))
        self.view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }
    
    func display(message: String, withTitle title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorMessage(message: String) {
        self.display(message: message, withTitle: "Error")
    }
}
