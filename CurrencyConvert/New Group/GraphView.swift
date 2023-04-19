

import SwiftUI
import Charts

struct GraphView: View {
    @ObservedObject var viewModel = GraphViewModel()
    var currencyData: [Date: Double] {
        return viewModel.dateRates
    }
    
    @State var isButtonVisible = true // Put it in the viewmodel
    
    var body: some View {
        VStack(alignment: .leading){
            
            
            Text("GBP - EUR")
                .foregroundColor(.white)
                .font(.caption)
                .padding(.horizontal, 20)
            
            
            
            
            
            ZStack {
                
                Chart {
                    ForEach(Array(currencyData.keys).sorted(), id: \.self) { date in
                        LineMark(
                            x: .value("Date", date, unit: .day),
                            y: .value("EUR", currencyData[date]!)
                        )
                    }
                }
                .frame(height: 120)
                .foregroundColor(Color("AccentColor2"))
                .chartXAxis {
                    AxisMarks(values: Array(currencyData.keys).sorted()) { date in
                        
                    }
                }
                .chartYAxis {
                    AxisMarks()
                }
                
                Button(action: {
                    viewModel.parseCurrencyData()
                    isButtonVisible = false
                }) {
                    Text("Refresh")
                        .font(.title3)
                        .foregroundColor(Color("AccentColor2"))
                }
                .frame(width: 100, height: 50)
                .border(Color("AccentColor2"), width: 2)
                .opacity(isButtonVisible ? 1.0 : 0.0)
                
            }.padding(.horizontal, 20)
        }
    }
}








struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView().preferredColorScheme(.dark)
    }
}
