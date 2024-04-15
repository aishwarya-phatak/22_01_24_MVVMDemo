//
//  APIManager.swift
//  22_01_24_MVVMDemo
//
//  Created by Vishal Jagtap on 13/04/24.
//

import Foundation

enum DataError : Error{
    case invalidResponse
    case invalidURL
    case invalidDecoding
    case network(Error?)
}

typealias Handler = ((Result<[Product],DataError>)->Void) //closure

//Singleton class and final to restrict inheritance
final class APIManager{
    static let shared = APIManager()
    private init(){}
    
    func fetchProducts(completion : @escaping Handler){
        guard let url = URL(string: Constant.API.productUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
    
            //this is wrong -- do not do this
//            guard let error = error else {
//                return
//            }
            
            guard let response = response as? HTTPURLResponse, 200...299
                    ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do{
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            }catch{
                completion(.failure(.invalidDecoding))
            }
        }.resume()
    }
}
