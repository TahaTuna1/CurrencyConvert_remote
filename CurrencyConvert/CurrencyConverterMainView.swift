//
//  CurrencyConverterMainView.swift
//  CurrencyConvert
//
//  Created by Taha Tuna on 13.04.2023.
//

import SwiftUI

struct CurrencyConverterMainView: View {
    @ObservedObject var viewModel = ExchangeRateViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.black).opacity(0.9).ignoresSafeArea()
            
            VStack {
                VStack {
                    
                        Spacer()
                    Text("Currency Converter").font(.title).foregroundColor(.white)
                        Spacer()
                        
                   
                    Spacer()
                    VStack{// Main Currency View.
                        HStack{
                            Text(viewModel.baseCurrencySymbol).padding(.leading, 20).font(.largeTitle).foregroundColor(.white)
                            
                            VStack {
                                TextField("How much?", value: $viewModel.baseCurrencyAmount, formatter: NumberFormatter())
                                    .font(.custom("baseCurrency", size: 50))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 1, x: 2, y:2)
                                    .onSubmit {
                                        viewModel.fetchExchangeRate()
                                    }
                            }
                            
                            
                            
                            
                            Image(systemName: "arrowtriangle.down")
                                .font(.title2).padding(.trailing, 20).foregroundColor(.white)
                            
                            
                        }
                        //Picker
                        Group {
                            
                            Picker("", selection: $viewModel.baseCurrencySelection) {
                                ForEach(viewModel.allCurrencies, id: \.code) { currency in
                                    Text("\(currency.symbolNative) - \(currency.code)")
                                }
                            }
                        }.padding(.bottom, 10)
                            .onChange(of: viewModel.baseCurrencySelection) { newValue in
                                viewModel.currencyChanged = true
                                viewModel.baseCurrency = newValue
                                viewModel.isLoading = true
                                viewModel.fetchExchangeRate()
                                viewModel.fetchSymbols()
                            }
                    }
                    
                        .fontWeight(.light)
                    
                }
                .frame(minHeight: 80, maxHeight: 230)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color("AccentColor2").opacity(1)]), startPoint: .top, endPoint: .bottom)
                )
                
                 
                
                SecondaryCurrencyView(isLoading: $viewModel.isLoading, currencyIcon: viewModel.secondCurrencySymbol, currencyName: viewModel.secondCurrency, amount: viewModel.secondCurrencyRate)
                SecondaryCurrencyView(isLoading: $viewModel.isLoading, currencyIcon: viewModel.thirdCurrencySymbol, currencyName: viewModel.thirdCurrency, amount: viewModel.thirdCurrencyRate)
                SecondaryCurrencyView(isLoading: $viewModel.isLoading, currencyIcon: viewModel.fourthCurrencySymbol, currencyName: viewModel.fourthCurrency, amount: viewModel.fourthCurrencyRate)
                
                
                //                Button {
                //                    viewModel.isLoading = true
                //                    viewModel.fetchExchangeRate()
                //                    viewModel.fetchSymbols()
                //                } label: {
                //                    Text("Refresh Rates")
                //                        .font(.body)
                //                        .foregroundColor(.white)
                //                        .frame(width: 190, height: 40)
                //                        .background(Color.blue.opacity(0.1))
                //                        .cornerRadius(radius: 40, corners: [.bottomLeft, .topRight])
                //                }
                
                
                
                
                
                
                
                
//                HStack{
//                    smallCurrencyView(currency: viewModel.baseCurrency, amount: 1, fontSize: 30)
//                    Spacer()
//
//                    VStack{ // Find a better solution to display the base rates
//                        smallCurrencyView(currency: viewModel.secondCurrency, amount: viewModel.secondCurrencyRate / viewModel.baseCurrencyAmount, fontSize: 20)
//                        smallCurrencyView(currency: viewModel.thirdCurrency, amount: viewModel.thirdCurrencyRate / viewModel.baseCurrencyAmount, fontSize: 20)
//                        smallCurrencyView(currency: viewModel.fourthCurrency, amount: viewModel.fourthCurrencyRate / viewModel.baseCurrencyAmount, fontSize: 20)
//                    }
//                }
//                .foregroundColor(.white)
//                .padding(35)
//                .font(.largeTitle)
//                .fontWeight(.light)
//                .frame(width: 370, height: 110)
//                .background(.white.opacity(0.08))
//                .cornerRadius(30)
//
                
                
                
                 
                                VStack {
                                    
                                    GraphView(graphCurrencyFrom: "EUR", graphCurrencyTo: "GBP")
                
                                }
                
            }
        }.onAppear {
            print("On launch, Base Currency: \(viewModel.baseCurrency)")
            viewModel.fetchSymbols()
            viewModel.baseCurrencySelection = viewModel.baseCurrency
        }
    }
}


struct smallCurrencyView: View{ // For the bottom
    var currency: String
    var amount: Double
    var fontSize: CGFloat
    var body: some View{
        
        Text("\(NumberFormatter.localizedString(from: NSNumber(value: amount), number: .decimal)) \(currency)").font(.system(size: fontSize))
    }
}


struct SecondaryCurrencyView: View{ // Smaller Currencies
    @Binding var isLoading: Bool
    var currencyIcon: String
    var currencyName: String
    var amount: Double
    var body: some View{
        HStack{
            HStack{
                VStack{
                    Text(currencyIcon)
                    Text(currencyName).font(.body).foregroundColor(.gray)
                }
                Image(systemName: "arrowtriangle.down").font(.callout).padding(10)
            }
            
            Spacer()
            
            
            HStack {
                if isLoading{
                    LoadingView()
                }else{
                    Text(NumberFormatter.localizedString(from: NSNumber(value: amount), number: .decimal))
                        .font(.title)
                }
            }
            
            
            
            
        }
        .foregroundColor(.white)
        .padding(25)
        .font(.largeTitle)
        .fontWeight(.light)
        .frame(width: 370, height: 100)
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.white.opacity(0.1), location: 0),
                    .init(color: Color.white.opacity(0), location: 1)
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(30)
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyConverterMainView().preferredColorScheme(.dark)
    }
}
