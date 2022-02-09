//
//  CheckoutView.swift
//  CupCakeCorner
//
//  Created by Alex Paz on 08/02/2022.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: SharedOrder
    
    @State private var alertMsg = ""
    @State private var showingAlert = false
    @State private var alertTop = "Thank you!"
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.items.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertTop, isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMsg)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.items) else {
//            print("Failed to encode order")
            alertMsg = "Failed to encode order"
            showingAlert = true
            return
        }
        
        // dumb server that sends back what you send to it
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(OrderItems.self, from: data)
            alertMsg = "Your order for \(decodedOrder.quantity)x \(SharedOrder.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingAlert = true
        } catch {
//            print("Checkout failed.")
            alertTop = "Sorry!"
            alertMsg = "Remote connection failed."
            showingAlert = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        CheckoutView(order: SharedOrder())
        }
    }
}
