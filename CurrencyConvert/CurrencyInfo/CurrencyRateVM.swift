//
//  CurrencyRateVM.swift
//  Currency Rate ViewModel - API Network Call + Read Local JSON

import SwiftUI


class ExchangeRateViewModel: ObservableObject {
    @Published var exchangeRate: ExchangeRate?
    @Published var isLoading = false
    @Published var allCurrencies: [Currency] = []
    @Published var baseCurrencySelection: String = ""
    @Published var currencyChanged: Bool = false
    var lastUpdate: Date? = nil
    
    @ObservedObject var currencyData = CurrencyData()
    //Still not elegant at all
    var baseCurrency: String {
        get { currencyData.baseCurrency }
        set { currencyData.baseCurrency = newValue }
    }
    
    var baseCurrencySymbol: String {
        get { currencyData.baseCurrencySymbol }
        set { currencyData.baseCurrencySymbol = newValue }
    }
    
    var baseCurrencyAmount: Double {
        get { currencyData.baseCurrencyAmount }
        set { currencyData.baseCurrencyAmount = newValue }
    }
    
    var secondCurrency: String {
        get { currencyData.secondCurrency }
        set { currencyData.secondCurrency = newValue }
    }
    
    var secondCurrencySymbol: String {
        get { currencyData.secondCurrencySymbol }
        set { currencyData.secondCurrencySymbol = newValue }
    }
    
    var secondCurrencyRate: Double {
        get { currencyData.secondCurrencyRate }
        set { currencyData.secondCurrencyRate = newValue }
    }
    
    var thirdCurrency: String {
        get { currencyData.thirdCurrency }
        set { currencyData.thirdCurrency = newValue }
    }
    
    var thirdCurrencySymbol: String {
        get { currencyData.thirdCurrencySymbol }
        set { currencyData.thirdCurrencySymbol = newValue }
    }
    
    var thirdCurrencyRate: Double {
        get { currencyData.thirdCurrencyRate }
        set { currencyData.thirdCurrencyRate = newValue }
    }
    
    var fourthCurrency: String {
        get { currencyData.fourthCurrency }
        set { currencyData.fourthCurrency = newValue }
    }
    
    var fourthCurrencySymbol: String {
        get { currencyData.fourthCurrencySymbol }
        set { currencyData.fourthCurrencySymbol = newValue }
    }
    
    var fourthCurrencyRate: Double {
        get { currencyData.fourthCurrencyRate }
        set { currencyData.fourthCurrencyRate = newValue }
    }
    
    let apiKey = ""
    
    func fetchExchangeRate() {
        
        let currencies = "\(secondCurrency)%2C\(thirdCurrency)%2C\(fourthCurrency)"
        guard let url = URL(string: "https://api.freecurrencyapi.com/v1/latest?apikey=\(apiKey)&currencies=\(currencies)&base_currency=\(baseCurrency)") else {
            fatalError("Invalid URL")
        }
        if let lastUpdate = lastUpdate, Date().timeIntervalSince(lastUpdate) < 3600, !currencyChanged{
            self.currencyUpdate()
            print(self.lastUpdate ?? "no last update found")
            print("No new network call")
                return
            }

        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let exchangeRate = try? decoder.decode(ExchangeRate.self, from: data) {
                    DispatchQueue.main.async {
                        print("Did another network call")
                        self.exchangeRate = exchangeRate
                        self.lastUpdate = Date()
                        self.currencyUpdate()
                        self.currencyChanged = false
                    }
                }
            }
        }.resume()
        
    }
    
    func currencyUpdate(){
        
        print(self.lastUpdate ?? "fail")
        if let secondCurrencyRate = exchangeRate?.data[self.secondCurrency] {
            self.secondCurrencyRate = self.baseCurrencyAmount * secondCurrencyRate
        }
        if let thirdCurrencyRate = exchangeRate?.data[self.thirdCurrency] {
            self.thirdCurrencyRate = self.baseCurrencyAmount * thirdCurrencyRate
        }
        if let fourthCurrencyRate = exchangeRate?.data[self.fourthCurrency] {
            self.fourthCurrencyRate = self.baseCurrencyAmount * fourthCurrencyRate
        }
        self.baseCurrencySelection = self.baseCurrency
        print("Base Currency: \(self.baseCurrencyAmount) \(self.baseCurrency)")
        print(self.exchangeRate ?? "Failed")
        self.isLoading = false
    }
    
    func fetchSymbols() {
        
        if let url = Bundle.main.url(forResource: "currencyInfo", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let response = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
                
                
                DispatchQueue.main.async {
                    
                    self.allCurrencies.removeAll()
                    for currency in response.data.values {
                        self.allCurrencies.append(currency)
                    }
                    self.allCurrencies.sort { $0.name < $1.name }
                    
                    if let symbol = response.data[self.baseCurrency]?.symbolNative {
                        self.baseCurrencySymbol = symbol
                    }
                    
                    if let symbol = response.data[self.secondCurrency]?.symbolNative {
                        self.secondCurrencySymbol = symbol
                    }
                    
                    if let symbol = response.data[self.thirdCurrency]?.symbolNative {
                        self.thirdCurrencySymbol = symbol
                    }
                    
                    if let symbol = response.data[self.fourthCurrency]?.symbolNative {
                        self.fourthCurrencySymbol = symbol
                    }
                    self.objectWillChange.send()
                    
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
