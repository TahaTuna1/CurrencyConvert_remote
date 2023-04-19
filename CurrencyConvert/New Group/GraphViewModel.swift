

import SwiftUI


class GraphViewModel: ObservableObject{
    @Published var dateRates: [Date: Double] = [:]
    
    
    @Published var graphCurrencyFrom: String = "GBP" // Defaults. Create a way to change them.
    @Published var graphCurrencyTo: String = "EUR"
    
    func parseCurrencyData() {
        let apiKey = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -2, to: today)!
        let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: today)!
        let dateToString: (Date) -> String = { date in
            dateFormatter.string(from: date) + "00%3A00%3A00.000"
        }
        let urlString = "https://api.freecurrencyapi.com/v1/historical?apikey=\(apiKey)&currencies=\(graphCurrencyTo)&base_currency=\(graphCurrencyFrom)&date_from=\(dateToString(thirtyDaysAgo))&date_to=\(dateToString(yesterday))"
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned.")
                return
            }
            
            do {
                print("Dates Fetched")
                let dateRates = try JSONDecoder().decode(GraphCurrencyData.self, from: data)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                DispatchQueue.main.async {
                    for (dateString, rate) in dateRates.data {
                        if let date = dateFormatter.date(from: dateString) {
                            self.dateRates[date] = rate.EUR
                        }
                    }
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    
    
    
}
