//
//  SymbolModel.swift
//  CurrencyConvert
//
//  Created by Taha Tuna on 16.04.2023.
//

import Foundation

struct Currency: Codable {
    let symbol: String
    let name: String
    let symbolNative: String
    let decimalDigits: Int
    let rounding: Int
    let code: String
    let namePlural: String

    enum CodingKeys: String, CodingKey {
        case symbol
        case name
        case symbolNative = "symbol_native"
        case decimalDigits = "decimal_digits"
        case rounding
        case code
        case namePlural = "name_plural"
    }
}

struct ExchangeRateResponse: Codable {
    let data: [String: Currency]
}
