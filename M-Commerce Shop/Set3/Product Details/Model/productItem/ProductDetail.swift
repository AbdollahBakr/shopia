//
//  ProductDetail.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 01.07.22.
//



import Foundation
struct ProductDetail : Codable {
    
    let product: ProductInfo?
    
}
struct ProductInfo: Codable{
    let id : Int?
    let title : String?
    let body_html: String?
    let vendor : String?
    let product_type : String?
    let variants : [VariantProduct]?
    let options : [Option]?
    let images : [Image]?
    let image : Image?
}
