//
//  RounderCorner.swift
//  CurrencyConvert
//
//  Created by Taha Tuna on 13.04.2023.
//

import SwiftUI

extension View{
    func cornerRadius(radius: CGFloat, corners: UIRectCorner ) -> some View{
        clipShape(RounderCorner(radius: radius, corners: corners))
    }
}

struct RounderCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

struct RounderCorner_Previews: PreviewProvider {
    static var previews: some View {
        RounderCorner(radius: 200, corners: [.bottomLeft, .bottomRight])
            .padding()
            .frame(width: 400, height: 200)
    }
}
