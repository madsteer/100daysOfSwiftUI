//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Cory Steers on 7/5/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: ObservableOrder
    
    var body: some View {
            Form {
                Section {
                    TextField("Name", text: $order.order.name)
                    TextField("Street Address", text: $order.order.streetAddress)
                    TextField("City", text: $order.order.city)
                    TextField("Zip", text: $order.order.zip)
                }
                
                Section {
                    NavigationLink {
                        CheckoutView(order: order)
                    } label: {
                        Text("Check Out")
                    }
                }
                .disabled(order.order.hasValidAddress == false)
            }
            .navigationTitle("Delivery Details")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(order: ObservableOrder())
        }
    }
}
