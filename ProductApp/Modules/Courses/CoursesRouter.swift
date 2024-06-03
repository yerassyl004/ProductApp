//
//  CoursesRouter.swift
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

@objc protocol CoursesRoutingLogic {
    
}

protocol CoursesDataPassing {
    var dataStore: CoursesDataStore? { get }
}

final class CoursesRouter: NSObject, CoursesRoutingLogic, CoursesDataPassing {
    weak var viewController: CoursesViewController?
    var dataStore: CoursesDataStore?
    
}