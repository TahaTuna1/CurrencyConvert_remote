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
                    HStack{//Top Icons
                        Image(systemName: "person")
                        Spacer()
                        Image(systemName: "directcurrent")
                        Spacer()
                        Image(systemName: "gear")
                    }.padding(10)
                        .font(.largeTitle).foregroundColor(.white)
                    
                    VStack{// Main Currency
                        HStack{
                            Text("$")
                            Spacer()
                            Text(String(viewmodel.baseCurrencyRate))
                                .font(.custom("mainCurrency", size: 45))
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
                
                
                
                
                SecondaryCurrencyView(currencyIcon: "€", currencyName: viewmodel.secondCurrency, amount: viewmodel.secondCurrencyRate)
                SecondaryCurrencyView(currencyIcon: "₺", currencyName: viewmodel.thirdCurrency, amount: viewmodel.thirdCurrencyRate)
                SecondaryCurrencyView(currencyIcon: "₽", currencyName: viewmodel.fourthCurrency, amount: viewmodel.fourthCurrencyRate)
                
                
//                Button {
//                    
//                } label: {
//                    Text("Add New Currency")
//                        .font(.body)
//                        .foregroundColor(.white)
//                        .frame(width: 190, height: 70)
//                        .background(Color.blue.opacity(0.1))
//                        .cornerRadius(radius: 40, corners: [.bottomLeft, .topRight])
//                }
                
                VStack {
                    Text("$ USD - Euro €").foregroundColor(.gray).padding(.top, 10)
                    Spacer()
                    Image("graphPlaceHolder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 40)
                        
                }
                .frame(minWidth: 300, maxWidth: 370, minHeight: 100, maxHeight: 170)
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
        }.onAppear {
            viewmodel.fetchExchangeRate()
        }
    }
}




struct SecondaryCurrencyView: View{
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

            
            Text(currencyIcon + NumberFormatter.localizedString(from: NSNumber(value: amount), number: .decimal)).font(.title)
                
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
