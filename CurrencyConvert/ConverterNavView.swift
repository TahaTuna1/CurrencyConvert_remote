

import SwiftUI

struct ConverterNavView: View {
    
    var body: some View {
        TabView{
            CurrencyConverterMainView()
                .tabItem {
                    
                    Label("Currency", systemImage: "dollarsign.circle.fill")
                    
                }
                
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.circle.fill")
                }
                
        }
        .ignoresSafeArea()
    }
}

struct ConverterNavView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterNavView()
    }
}
