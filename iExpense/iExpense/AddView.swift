//
//  AddView.swift
//  iExpense
//
//  Created by Cory Steers on 4/12/23.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var buildLists: () -> Void
        
    let types = [ "Business", "Personal" ]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id:\.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount",
                          value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                )
                    .keyboardType(.decimalPad)
            }
            .toolbar {
                Button("Save") {
                    expenses.items.append(ExpenseItem(name: name, type: type, amount: amount))
                    buildLists()
                    dismiss()
                }
            }
        }
    }
}

func mock() {
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses(), buildLists: mock)
    }
}
