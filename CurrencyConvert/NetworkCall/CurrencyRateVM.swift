//
//  CurrencyRateVM.swift
//  Currency Rate ViewModel - API Network Call

import SwiftUI


class ExchangeRateViewModel: ObservableObject {
    @Published var exchangeRate: ExchangeRate?
    
    // Not very elegant, it is?
    var baseCurrency = CurrencyData().baseCurrency
    var baseCurrencyAmount = CurrencyData().baseCurrencyAmount
    var secondCurrency = CurrencyData().secondCurrency
    var secondCurrencyRate = CurrencyData().secondCurrencyRate
    var thirdCurrency = CurrencyData().thirdCurrency
    var thirdCurrencyRate = CurrencyData().thirdCurrencyRate
    var fourthCurrency = CurrencyData().fourthCurrency
    var fourthCurrencyRate = CurrencyData().fourthCurrencyRate
    
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
                            self.secondCurrencyRate = self.baseCurrencyAmount * secondCurrencyRate
                        }
                        if let thirdCurrencyRate = exchangeRate.data[self.thirdCurrency] {
                            self.thirdCurrencyRate = self.baseCurrencyAmount * thirdCurrencyRate
                        }
                        if let fourthCurrencyRate = exchangeRate.data[self.fourthCurrency] {
                            self.fourthCurrencyRate = self.baseCurrencyAmount * fourthCurrencyRate
                        }
                        
                    }
                }
            }
        }.resume()
    }
}
