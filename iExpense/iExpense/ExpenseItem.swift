//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Cory Steers on 4/12/23.
//

import Foundation

extension Array where Element == ExpenseItem {
    func expenseTypeFilter(desired value: String) -> [ExpenseItem] {
        let filtered = self.filter({ item in
            item.type == value
        })
        
        return filtered
    }
    
    func findExpense(for item: ExpenseItem) -> Index {
        let index = self.firstIndex(where: { $0.id == item.id })
        return index ?? Index(-1)
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
