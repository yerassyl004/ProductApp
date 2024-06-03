//
//  ProductRouter.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 03.06.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol ProductRoutingLogic {
    
}

protocol ProductDataPassing {
    var dataStore: ProductDataStore? { get }
}

class ProductRouter: NSObject, ProductRoutingLogic, ProductDataPassing {
    weak var viewController: ProductViewController?
    var dataStore: ProductDataStore?
    
}
