//
//  Order.swift
//  CupcakeCorner
//
//  Created by Cory Steers on 7/5/23.
//

import SwiftUI

class Order: ObservableObject {
    static let types = [ "Vanilla", "Strawberry", "Chocolate", "Rainbow" ]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
}
