//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Cory Steers on 4/12/23.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}