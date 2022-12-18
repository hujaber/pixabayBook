//
//  UIViewController.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import UIKit

extension UIViewController {
    
    private var loaderTag: Int {
        1984
    }
    
    func showLoader() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.tag = loaderTag
        view.addSubview(activityIndicator)
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
