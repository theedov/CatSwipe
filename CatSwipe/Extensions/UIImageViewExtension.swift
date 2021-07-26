//
//  UIImageViewExtension.swift
//  CatSwipe
//
//  Created by Theo on 26/7/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadImage(from url: URL?) {
        guard let url = url else {
            image = nil
            return
        }
        
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
}
