//
//  ContentView.swift
//  CupCakeCorner
//
//  Created by Alex Paz on 04/02/2022.
//

import SwiftUI


struct ContentView: View {
    @StateObject var order = SharedOrder()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(SharedOrder.types.indices) {
                            Text(SharedOrder.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.items.quantity)", value: $order.items.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.items.specialRequestEnabled.animation())
                    
                    if order.items.specialRequestEnabled {
                        Toggle("Extra frosting?", isOn: $order.items.extraFrosting)
                        Toggle("Add sprinkles?", isOn: $order.items.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery details", destination: AddressView(order: order))
                }
            }
            .navigationTitle("CupCake Corner")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
