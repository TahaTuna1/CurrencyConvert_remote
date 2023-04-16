//
//  ContentView.swift
//  CurrencyConvert
//
//  Created by Taha Tuna on 13.04.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewmodel = ExchangeRateViewModel()
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.black).opacity(0.9).ignoresSafeArea()
            
            VStack {
                VStack {
                    HStack{//Top Icons - No functionality yet
                        Image(systemName: "person")
                        Spacer()
                        Image(systemName: "directcurrent")
                        Spacer()
                        Image(systemName: "gear")
                    }.padding(10)
                        .font(.largeTitle).foregroundColor(.white)
                    
                    VStack{// Main Currency View.
                        HStack{
                            Text(viewmodel.baseCurrencySymbol)
                            Spacer()
                            TextField("How much?", value: $viewmodel.baseCurrencyAmount, formatter: NumberFormatter())
                                .font(.custom("baseCurrency", size: 50))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .shadow(color: .cyan, radius: 1, x: 2, y:2)
                            
                            Spacer()
                            Image(systemName: "arrowtriangle.down")
                                .font(.title2)
                        }
                        Text(viewmodel.baseCurrency)
                            .font(.title3).foregroundColor(.gray)
                    }.foregroundColor(.white)
                        .font(.largeTitle)
                        .padding(30)
                        .fontWeight(.light)
                }
                .frame(minHeight: 80, maxHeight: 200)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.cyan.opacity(0.3), .white.opacity(0)]), startPoint: .top, endPoint: .bottom)
                )
                
                
                
                
                SecondaryCurrencyView(isLoading: $viewmodel.isLoading, currencyIcon: viewmodel.secondCurrencySymbol, currencyName: viewmodel.secondCurrency, amount: viewmodel.secondCurrencyRate)
                SecondaryCurrencyView(isLoading: $viewmodel.isLoading, currencyIcon: viewmodel.thirdCurrencySymbol, currencyName: viewmodel.thirdCurrency, amount: viewmodel.thirdCurrencyRate)
                SecondaryCurrencyView(isLoading: $viewmodel.isLoading, currencyIcon: viewmodel.fourthCurrencySymbol, currencyName: viewmodel.fourthCurrency, amount: viewmodel.fourthCurrencyRate)
                
                
                Button {
                    viewmodel.isLoading = true
                    viewmodel.fetchExchangeRate()
                    
                    print("Base Currency: \(viewmodel.baseCurrencyAmount) \(viewmodel.baseCurrency)")
                    print(viewmodel.exchangeRate ?? "Failed. Something's wrong.")
                    
                } label: {
                    Text("Refresh Rates")
                        .font(.body)
                        .foregroundColor(.white)
                        .frame(width: 190, height: 40)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(radius: 40, corners: [.bottomLeft, .topRight])
                }
                Button {
                    viewmodel.fetchSymbols()
                    print(viewmodel.baseCurrencySymbol)
                    
                } label: {
                    Text("Refresh Symbol")
                        .font(.body)
                        .foregroundColor(.white)
                        .frame(width: 190, height: 40)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(radius: 40, corners: [.bottomLeft, .topRight])
                }
                
                
                HStack{
                    smallCurrencyView(currency: viewmodel.baseCurrency, amount: 1, fontSize: 30)
                    Spacer()
                    
                    VStack{ // Find a better solution  to display the base rates
                        smallCurrencyView(currency: viewmodel.secondCurrency, amount: viewmodel.secondCurrencyRate / viewmodel.baseCurrencyAmount, fontSize: 20)
                        smallCurrencyView(currency: viewmodel.thirdCurrency, amount: viewmodel.thirdCurrencyRate / viewmodel.baseCurrencyAmount, fontSize: 20)
                        smallCurrencyView(currency: viewmodel.fourthCurrency, amount: viewmodel.fourthCurrencyRate / viewmodel.baseCurrencyAmount, fontSize: 20)
                    }
                }
                .foregroundColor(.white)
                .padding(35)
                .font(.largeTitle)
                .fontWeight(.light)
                .frame(width: 370, height: 110)
                .background(.white.opacity(0.05))
                .cornerRadius(30)
                
                
                // Graph. Commented until further notice
                //                VStack {
                //                    Text("$ USD - Euro €").foregroundColor(.gray).padding(.top, 10)
                //                    Spacer()
                //                    Image("graphPlaceHolder")
                //                        .resizable()
                //                        .aspectRatio(contentMode: .fit)
                //                        .padding(.bottom, 40)
                //
                //                }
                //                .frame(minWidth: 300, maxWidth: 370, minHeight: 100, maxHeight: 170)
                //                .background(
                //                    LinearGradient(
                //                        gradient: Gradient(stops: [
                //                            .init(color: Color.white.opacity(0.05), location: 0),
                //                            .init(color: Color.white.opacity(0), location: 1)
                //                        ]),
                //                        startPoint: .leading,
                //                        endPoint: .trailing
                //                    )
                //                )
                //                .cornerRadius(30)
                
            }
        }.onAppear {// NO LONGER FETCHING DATA ON LAUNCH FOR TESTING PURPOSES!!!
            print("On launch, Base Currency: \(viewmodel.baseCurrency)")
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
        .padding(35)
        .font(.largeTitle)
        .fontWeight(.light)
        .frame(width: 370, height: 110)
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.white.opacity(0.05), location: 0),
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
        ContentView()
    }
}
