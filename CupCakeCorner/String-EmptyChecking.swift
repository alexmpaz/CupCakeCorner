//
//  String-EmptyChecking.swift
//  CupCakeCorner
//
//  Created by Alex Paz on 09/02/2022.
//

import Foundation

extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
