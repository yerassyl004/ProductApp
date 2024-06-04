//
//  UICollectionView+Register.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 04.06.2024.
//

import UIKit
import Foundation

extension UICollectionView {
    
    func registerCell<Cell: UICollectionViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseID)
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.reuseID, for: indexPath)
                as? Cell else {
            fatalError("Fatal error for cell at \(indexPath))")
        }
        return cell
    }
}
