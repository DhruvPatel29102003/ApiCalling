//
//  CustomLoaderView.swift
//  Apicalling SD
//
//  Created by Droadmin on 07/12/23.
//

import Foundation
import UIKit

class CustomLoaderView: UIView {
    private var activityIndicator: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLoader()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLoader()
    }

    private func setupLoader() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    func startLoading() {
        activityIndicator.startAnimating()
        self.isHidden = false
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
        self.isHidden = true
    }
}
