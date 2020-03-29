//
//  DecimalExtensions.swift
//  IceCreamParlorChallenge
//
//  Created by Cris on 29/03/20.
//  Copyright © 2020 Ingrid Guerrero. All rights reserved.
//

import Foundation

extension Decimal {
    func deciamlToString() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber) ?? "$0.0"
    }
}
