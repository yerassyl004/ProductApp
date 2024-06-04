//
//  ProductWorker.swift
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
import CoreData

protocol ProductWorkerProtocol {
    func fetchProductData(completion: @escaping ([Product.ViewModel]) -> Void)
}

class ProductWorker: ProductWorkerProtocol {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchProductData(completion: @escaping ([Product.ViewModel]) -> Void) {
        do {
            let productDataArray = try context.fetch(ProductData.fetchRequest()) as? [ProductData]
            
            guard let productDataArray else {
                print("Zero items, loading default data")
                return
            }
            if productDataArray.isEmpty {
                let defaultData = getDefaultData()
                saveDefaultDataToCoreData(defaultData)
                completion(defaultData)
            }
            let viewModelArray = productDataArray.map { Product.ViewModel(productData: $0) }
            completion(viewModelArray)
            
        } catch let error {
            print("Failed to fetch items with error: \(error)")
            completion(getDefaultData())
        }
    }
    
    func deleteAllData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ProductData.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("All data deleted successfully.")
        } catch let error {
            print("Failed to delete all data with error: \(error)")
        }
    }
    
    func getDefaultData() -> [Product.ViewModel] {
        let model = [
            Product.ViewModel(productTitle: "iPhone 15 Pro",
                              productImage: "iPhone15pro",
                              productAmount: "499990 KZT"),
            Product.ViewModel(productTitle: "iPhone 14 Pro",
                              productImage: "iPhone15pro",
                              productAmount: "459990 KZT"),
            Product.ViewModel(productTitle: "iPhone 13 Pro",
                              productImage: "iPhone15pro",
                              productAmount: "409990 KZT"),
            Product.ViewModel(productTitle: "iPhone 12 Pro",
                              productImage: "iPhone15pro",
                              productAmount: "409990 KZT"),
            Product.ViewModel(productTitle: "iPhone 11 Pro",
                              productImage: "iPhone15pro",
                              productAmount: "409990 KZT"),
            Product.ViewModel(productTitle: "iPhone 13",
                              productImage: "iPhone15pro",
                              productAmount: "409990 KZT"),
            Product.ViewModel(productTitle: "iPhone 13 Pro Max",
                              productImage: "iPhone15pro",
                              productAmount: "409990 KZT"),
            Product.ViewModel(productTitle: "iPhone 14 Pro Max",
                              productImage: "iPhone15pro",
                              productAmount: "409990 KZT"),
            Product.ViewModel(productTitle: "iPhone 15 Pro Max",
                              productImage: "iPhone15pro",
                              productAmount: "409990 KZT")
        ]
        
        return model
    }
    
    private func saveDefaultDataToCoreData(_ defaultData: [Product.ViewModel]) {
        for viewModel in defaultData {
            let productData = ProductData(context: context)
            productData.productTitle = viewModel.productTitle
            productData.productImageName = viewModel.productImage
            productData.productAmount = viewModel.productAmount
            productData.isAdded = viewModel.isAdded
        }
        
        do {
            try context.save()
        } catch let error {
            print("Failed to save default data with error: \(error)")
        }
    }
}

extension Product.ViewModel {
    init(productData: ProductData) {
        self.productTitle = productData.productTitle ?? ""
        self.productImage = productData.productImageName ?? ""
        self.productAmount = productData.productAmount ?? ""
        self.isAdded = productData.isAdded
    }
}
