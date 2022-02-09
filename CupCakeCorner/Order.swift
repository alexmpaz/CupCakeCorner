//
//  Order.swift
//  CupCakeCorner
//
//  Created by Alex Paz on 07/02/2022.
//

import SwiftUI

@dynamicMemberLookup
class SharedOrder: ObservableObject {
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var items = OrderItems()
    
//    subscript<T>(dynamicMember keyPath: KeyPath<OrderItems, T>) -> T {
//            items[keyPath: keyPath]
//        }  // no need for this one since the next subscript already has a getter
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<OrderItems, T>) -> T {
        get {
            items[keyPath: keyPath]
        }
        
        set {
            items[keyPath: keyPath] = newValue
        }
    }
    
//    @Published var type = 0
//    @Published var quantity = 3
//    
//    @Published var specialRequestEnabled = false {
//        didSet { // suggested by Paul, but I'd rather not reset the other bools by default
//            if specialRequestEnabled == false {
//                extraFrosting = false
//                addSprinkles = false
//            }
//        }
//    }
//    @Published var extraFrosting = false
//    @Published var addSprinkles = false
//    
//    @Published var name = ""
//    @Published var streetAddress = ""
//    @Published var city = ""
//    @Published var zip = ""
    
    
    
    
    
//    init() { }  // since Codable protocol can be removed, this custom initializer is no longer needed
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(items.type, forKey: .type)
//        try container.encode(items.quantity, forKey: .quantity)
//
//        try container.encode(items.extraFrosting, forKey: .extraFrosting)
//        try container.encode(items.addSprinkles, forKey: .addSprinkles)
//
//        try container.encode(items.name, forKey: .name)
//        try container.encode(items.streetAddress, forKey: .streetAddress)
//        try container.encode(items.city, forKey: .city)
//        try container.encode(items.zip, forKey: .zip)
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        items.type = try container.decode(Int.self, forKey: .type)
//        items.quantity = try container.decode(Int.self, forKey: .quantity)
//
//        items.extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        items.addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//        items.name = try container.decode(String.self, forKey: .name)
//        items.streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        items.city = try container.decode(String.self, forKey: .city)
//        items.zip = try container.decode(String.self, forKey: .zip)
//    }
}

struct OrderItems: Codable {
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet { // suggested by Paul, but I'd rather not reset the other bools by default
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
    
    var hasValidAddress: Bool {
//        let _name, _streetAddress, _city, _zip = name.trimmingCharacters(in: .whitespacesAndNewlines),
//        for var word in ([name, streetAddress, city, zip]) {
//            word = word.trimmingCharacters(in: .whitespacesAndNewlines)
//        }
        if name.isReallyEmpty || streetAddress.isReallyEmpty || city.isReallyEmpty || zip.isReallyEmpty {
//        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
}
