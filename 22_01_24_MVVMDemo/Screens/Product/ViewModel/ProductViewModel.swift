//
//  ProductViewModel.swift
//  22_01_24_MVVMDemo
//
//  Created by Vishal Jagtap on 15/04/24.
//

import Foundation

final class ProductViewModel{
    var products : [Product] = []
    var eventHandler : ((_ event : Event)->Void)?
    
    func fetchProducts(){
        //self.eventHandler!(.loading)
        APIManager.shared.fetchProducts { response in
            self.eventHandler!(.stopLoading)
            switch response{
            case .success(let products):
                self.products = products
                self.eventHandler!(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler!(.error(error))
            }
        }
    }
}

extension ProductViewModel{
    enum Event{
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
