

import Foundation

extension Date{
    var eighteenYeasAgo: Date{
        Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    }
    var oneHundredTenYearsAgo: Date{
        Calendar.current.date(byAdding: .year, value: -100, to: Date())!
    }
}
