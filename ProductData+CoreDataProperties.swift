//
//  ProductData+CoreDataProperties.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 04.06.2024.
//
//

import Foundation
import CoreData


extension ProductData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductData> {
        return NSFetchRequest<ProductData>(entityName: "ProductData")
    }

    @NSManaged public var productTitle: String?
    @NSManaged public var productAmount: String?
    @NSManaged public var productImageName: String?
    @NSManaged public var isAdded: Bool

}

extension ProductData : Identifiable {

}
