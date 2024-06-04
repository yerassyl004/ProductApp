//
//  ProductFavorites+CoreDataProperties.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 04.06.2024.
//
//

import Foundation
import CoreData


extension ProductFavorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductFavorites> {
        return NSFetchRequest<ProductFavorites>(entityName: "ProductFavorites")
    }

    @NSManaged public var productTitle: String?
    @NSManaged public var productImageName: String?
    @NSManaged public var productAmount: String?
    @NSManaged public var isAdded: Bool

}

extension ProductFavorites : Identifiable {

}
