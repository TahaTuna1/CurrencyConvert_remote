//
//  CurrencyRateVM.swift
//  CurrencyConvert
//
//  Created by Taha Tuna on 14.04.2023.
//

import SwiftUI


class ExchangeRateViewModel: ObservableObject {
    @Published var exchangeRate: ExchangeRate?
    var baseCurrency = "PLN"
    var baseCurrencyRate: Double = 88632.8
    var secondCurrency = "EUR"
    var secondCurrencyRate: Double = 0.0
    var thirdCurrency = "TRY"
    var thirdCurrencyRate: Double = 0.0
    var fourthCurrency = "RUB"
    var fourthCurrencyRate: Double = 0.0
    
    let apiKey = ""
    
    func fetchExchangeRate() {
        let currencies = "\(secondCurrency)%2C\(thirdCurrency)%2C\(fourthCurrency)"
        guard let url = URL(string: "https://api.freecurrencyapi.com/v1/latest?apikey=\(apiKey)&currencies=\(currencies)&base_currency=\(baseCurrency)") else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                
                if let exchangeRate = try? decoder.decode(ExchangeRate.self, from: data) {
                    DispatchQueue.main.async {
                        self.exchangeRate = exchangeRate
                        
                        if let secondCurrencyRate = exchangeRate.data[self.secondCurrency] {
                            self.secondCurrencyRate = self.baseCurrencyRate * secondCurrencyRate
                        }
                        if let thirdCurrencyRate = exchangeRate.data[self.thirdCurrency] {
                            self.thirdCurrencyRate = self.baseCurrencyRate * thirdCurrencyRate
                        }
                        if let fourthCurrencyRate = exchangeRate.data[self.fourthCurrency] {
                            self.fourthCurrencyRate = self.baseCurrencyRate * fourthCurrencyRate
                        }
                    }
                }
            }
        }.resume()
    }
}
