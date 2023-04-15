//
//  CurrencyRateModel.swift
//  CurrencyConvert Model

import Foundation


struct ExchangeRate: Codable {
    let data: [String: Double]
}

class CurrencyData: ObservableObject {
    @Published var baseCurrency: String
    @Published var baseCurrencyAmount: Double
    @Published var secondCurrency: String
    @Published var secondCurrencyRate: Double
    @Published var thirdCurrency: String
    @Published var thirdCurrencyRate: Double
    @Published var fourthCurrency: String
    @Published var fourthCurrencyRate: Double
    
    init() {
        // Mock data
        baseCurrency = "PLN"
        baseCurrencyAmount = 214.9
        secondCurrency = "EUR"
        secondCurrencyRate = 0.0
        thirdCurrency = "TRY"
        thirdCurrencyRate = 0.0
        fourthCurrency = "RUB"
        fourthCurrencyRate = 0.0
    }
}
