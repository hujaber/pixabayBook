//
//  UIViewController.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import UIKit

// MARK: - Loader
extension UIViewController {
    
    private var loaderTag: Int {
        1984
    }
    
    func showLoader() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.tag = loaderTag
        activityIndicator.tintColor = .blue
        
        view.insertSubview(activityIndicator, at: 10)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func removeLoader() {
        if let loader = view.subviews.first(where: { $0.tag == loaderTag }) {
            loader.removeFromSuperview()
        }
    }
}

// MARK: Errors
extension UIViewController {
    func showAlert(forError error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
