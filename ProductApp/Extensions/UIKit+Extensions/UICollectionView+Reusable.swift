//
//  UICollectionView+Reusable.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 04.06.2024.
//

import Foundation
import UIKit

extension UICollectionViewCell: Reusable {}

extension Reusable where Self: UICollectionViewCell {
    
    static var reuseID: String {
        return String(describing: self)
    }
}
