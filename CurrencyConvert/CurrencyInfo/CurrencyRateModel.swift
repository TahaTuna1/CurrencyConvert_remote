//
//  CurrencyRateModel.swift
//  CurrencyConvert Model

import Foundation


struct ExchangeRate: Codable {
    let data: [String: Double]
}

class CurrencyData: ObservableObject { // Maybe combine?
    
    @Published var baseCurrency: String
    @Published var baseCurrencySymbol: String
    @Published var baseCurrencyAmount: Double
    @Published var secondCurrency: String
    @Published var secondCurrencySymbol: String
    @Published var secondCurrencyRate: Double
    @Published var thirdCurrency: String
    @Published var thirdCurrencySymbol: String
    @Published var thirdCurrencyRate: Double
    @Published var fourthCurrency: String
    @Published var fourthCurrencySymbol: String
    @Published var fourthCurrencyRate: Double
    
    init() {
        // Mock data
        baseCurrency = "PLN"
        baseCurrencySymbol = "?"
        baseCurrencyAmount = 1.0
        secondCurrency = "EUR"
        secondCurrencySymbol = "?"
        secondCurrencyRate = 0.0
        thirdCurrency = "TRY"
        thirdCurrencySymbol = "?"
        thirdCurrencyRate = 0.0
        fourthCurrency = "RUB"
        fourthCurrencySymbol = "?"
        fourthCurrencyRate = 0.0
        
    }
}
