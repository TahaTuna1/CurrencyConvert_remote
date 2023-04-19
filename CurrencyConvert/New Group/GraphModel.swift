import Foundation


struct GraphCurrencyData: Codable {
    let data: [String: CurrencyRate]
    
    struct CurrencyRate: Codable {
        let EUR: Double
    }
}
