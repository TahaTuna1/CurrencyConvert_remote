//
//  CurrencyRateVM.swift
//  Currency Rate ViewModel - API Network Call

import SwiftUI


class ExchangeRateViewModel: ObservableObject {
    @Published var exchangeRate: ExchangeRate?
    @Published var isLoading = false
    @Published var currencies: [Currency] = []
    // Not very elegant, it is?
    var baseCurrency = CurrencyData().baseCurrency
    var baseCurrencySymbol = CurrencyData().baseCurrencySymbol
    var baseCurrencyAmount = CurrencyData().baseCurrencyAmount
    var secondCurrency = CurrencyData().secondCurrency
    var secondCurrencySymbol = CurrencyData().secondCurrencySymbol
    var secondCurrencyRate = CurrencyData().secondCurrencyRate
    var thirdCurrency = CurrencyData().thirdCurrency
    var thirdCurrencySymbol = CurrencyData().thirdCurrencySymbol
    var thirdCurrencyRate = CurrencyData().thirdCurrencyRate
    var fourthCurrency = CurrencyData().fourthCurrency
    var fourthCurrencySymbol = CurrencyData().fourthCurrencySymbol
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
                        self.isLoading = false
                    }
                }
            }
        }.resume()
    }
    
    func fetchSymbols() {
        
        guard let url = URL(string: "https://api.freecurrencyapi.com/v1/currencies?apikey=\(apiKey)&currencies=") else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                do {
                    let response = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
                    
                    self.currencies = Array(response.data.values)
                    print(self.currencies)
                    
                    if let matchingCurrency = self.currencies.first(where: { $0.code == self.baseCurrency }) {
                        self.baseCurrencySymbol = matchingCurrency.symbolNative
                        print(self.baseCurrencySymbol)
                    }
                    if let matchingCurrency = self.currencies.first(where: { $0.code == self.secondCurrency }) {
                        self.secondCurrencySymbol = matchingCurrency.symbolNative
                    }
                    if let matchingCurrency = self.currencies.first(where: { $0.code == self.thirdCurrency }) {
                        self.thirdCurrencySymbol = matchingCurrency.symbolNative
                    }
                    if let matchingCurrency = self.currencies.first(where: { $0.code == self.fourthCurrency }) {
                        self.fourthCurrencySymbol = matchingCurrency.symbolNative
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
