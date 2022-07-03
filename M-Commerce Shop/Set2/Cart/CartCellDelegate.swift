//
//  CartCellDelegate.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 01/07/2022.
//

import Foundation

protocol CartCellDelegate {
    func didTapDeleteButton(item: Edge)
    func didChangeItemQuantity(item: Edge, newValue: Int)
}
