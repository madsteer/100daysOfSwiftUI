//
//  Expenses.swift
//  iExpense
//
//  Created by Cory Steers on 4/12/23.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
