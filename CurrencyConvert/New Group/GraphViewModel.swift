

import SwiftUI


class GraphViewModel: ObservableObject{
    @Published var dateRates: [Date: Double] = [:]
    
     func parseCurrencyData() {
        let apiKey = ""
        
        let urlString = "https://api.freecurrencyapi.com/v1/historical?apikey=\(apiKey)&currencies=EUR&base_currency=GBP&date_from=2022-04-17T17%3A37%3A39.583Z&date_to=2023-04-17T17%3A37%3A39.584Z"
        
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
