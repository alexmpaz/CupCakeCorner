//
//  ContentView.swift
//  CupCakeCorner
//
//  Created by Alex Paz on 04/02/2022.
//

import SwiftUI


struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled {
                        Toggle("Extra frosting?", isOn: $order.extraFrosting)
                        Toggle("Add sprinkles?", isOn: $order.addSprinkles)
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
