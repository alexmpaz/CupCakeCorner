//
//  AddressView.swift
//  CupCakeCorner
//
//  Created by Alex Paz on 08/02/2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: SharedOrder
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.items.name)
                TextField("Street address", text: $order.items.streetAddress)
                TextField("City", text: $order.items.city)
                TextField("Zip", text: $order.items.zip)
            }
            
            Section {
                NavigationLink("Check out", destination: CheckoutView(order: order))
            }
            .disabled(order.items.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(order: SharedOrder())
        }
    }
}
