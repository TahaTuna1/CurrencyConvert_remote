//
//  LoadingView.swift
//  CurrencyConvert
//
//  Created by Taha Tuna on 15.04.2023.
//

import SwiftUI


struct LoadingView: View{ // Show loading view until the fetching is complete. Need to add isLoading.
    var body: some View{
        ZStack{
            ProgressView() // New way SwiftUI. Title optional
                .progressViewStyle(CircularProgressViewStyle(tint: .cyan))
                
        }
    }
}
