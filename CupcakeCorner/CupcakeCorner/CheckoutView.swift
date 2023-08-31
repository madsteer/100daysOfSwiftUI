//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Cory Steers on 7/5/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: ObservableOrder
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var postErrorMessage = ""
    @State private var showingPostError = false
    
    private let urlString = "https://hws.dev/img/cupcakes@3x.jpg"
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: urlString), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .accessibilityHidden(true)
                
                Text("Your total is \(order.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task { // this allows us to make an async call in the Button action
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
        .alert("Ruh Roh!", isPresented: $showingPostError) {
            Button("OK") { }
        } message: {
            Text(postErrorMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            let msg = "Failed to encode order"
            print(msg)
            popError(with: msg)
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(ObservableOrder.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.order.quantity)x \(Order.types[decodedOrder.order.type].lowercased()) cupcakes is on it's way!"
            showingConfirmation = true
        } catch {
            let msg = "Checkout failed to complete."
            print("\(msg)\n\n\(error)\n\n")
            popError(with: msg)
        }
    }
    
    func popError(with message: String) {
        postErrorMessage = message
        showingPostError = true
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(order: ObservableOrder())
        }
    }
}
