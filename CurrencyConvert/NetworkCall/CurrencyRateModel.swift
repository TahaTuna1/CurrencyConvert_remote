//
//  CurrencyRateModel.swift
//  CurrencyConvert
//
//  Created by Taha Tuna on 14.04.2023.
//

import Foundation


struct ExchangeRate: Codable {
    let data: [String: Double]
}

struct CurrencyData {
    var baseCurrency: String
    var baseCurrencyRate: Double = 88632.8
    var secondCurrency: String
    var secondCurrencyRate: Double = 0.0
    var thirdCurrency: String
    var thirdCurrencyRate: Double = 0.0
    var fourthCurrency: String
    var fourthCurrencyRate: Double = 0.0
    
    init() {
        // Mock data
        baseCurrency = "EUR"
        baseCurrencyRate = 1.0
        secondCurrency = "USD"
        secondCurrencyRate = 0.9
        thirdCurrency = "TRY"
        thirdCurrencyRate = 0.11
        fourthCurrency = "RUB"
        fourthCurrencyRate = 0.012
    }
}
