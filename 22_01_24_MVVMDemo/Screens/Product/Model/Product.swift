//
//  Product.swift
//  22_01_24_MVVMDemo
//
//  Created by Vishal Jagtap on 13/04/24.
//

import Foundation
struct Product : Decodable{
    var id : Int
    var title : String
    var rating : Rating
}

struct Rating : Decodable{
    var rate : Double
    var count : Int
}
