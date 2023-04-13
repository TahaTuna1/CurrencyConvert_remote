//
//  ContentView.swift
//  CurrencyConvert
//
//  Created by Taha Tuna on 13.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color("primaryCustom").ignoresSafeArea()
            
            
            VStack {
                VStack {
                    HStack{//Top Icons
                        Image(systemName: "person")
                            .padding(20)
                        Spacer()
                        Image(systemName: "directcurrent")
                            .padding(20)
                        Spacer()
                        Image(systemName: "gear")
                            .padding(20)
                    }
                    .font(.largeTitle)
                    Spacer()
                    
                    HStack{// Main Currency
                        Text("$")
                        Spacer()
                        VStack{
                            Text("8,650.11")
                                .font(.custom("mainCurrency", size: 45))
                            Text("USD")
                                .font(.title3)
                        }
                        Spacer()
                        Image(systemName: "arrowtriangle.down")
                            .font(.title2)
                        
                    }
                    .font(.largeTitle)
                    .padding(30)
                    .fontWeight(.light)
                }
                .frame(minHeight: 200, maxHeight: 250)
                .background(Color.accentColor.ignoresSafeArea())
                
                
               Spacer()
                
                
                HStack{
                    HStack{
                        VStack{
                            Text("€")
                            Text("Euro").font(.body)
                        }
                        Image(systemName: "arrowtriangle.down").font(.body)
                    }
                    
                    Spacer()
                    
                    Text("€7,824.79")
                }
                .foregroundColor(.white)
                .padding(35)
                .font(.largeTitle)
                .fontWeight(.light)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
