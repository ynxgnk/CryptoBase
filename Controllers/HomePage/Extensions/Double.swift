//
//  Double.swift
//  swiftCoin
//
//  Created by Johel Zarco on 08/12/22.
//

import Foundation

// number formatter

extension Double{ /* 563 */
    
    private var currencyFormatter : NumberFormatter{ /* 563 */
        let formatter = NumberFormatter() /* 563 */
        formatter.usesGroupingSeparator = true /* 563 */
        formatter.numberStyle = .currency /* 563 */
        formatter.minimumFractionDigits = 2 // min and max digits /* 563 */
        formatter.maximumFractionDigits = 2 /* 563 */
        return formatter /* 563 */
    }
    
    private var numberFormatter : NumberFormatter{ /* 563 */
        let formatter = NumberFormatter() /* 563 */
        formatter.numberStyle = .decimal /* 563 */
        formatter.minimumFractionDigits = 2 // min and max digits /* 563 */
        formatter.maximumFractionDigits = 4 /* 563 */
        return formatter /* 563 */
    }
    
    func toCurrency() -> String{ /* 563 */
        return currencyFormatter.string(for: self) ?? "$0.00" /* 563 */
    }
    
    func toPercentageString() -> String{ /* 563 */
        // in this case self references to the Double type
        guard let numberAsString = numberFormatter.string(for: self) else { return ""} /* 563 */
        return numberAsString + "%" /* 563 */
    }
     
    func asNumberString() -> String{ /* 563 */
        return String(format: "%.2f", self) /* 563 */
    }
    
    func formattedWithAbbreviations() -> String{ /* 563 */
        let num = abs(Double(self)) /* 563 */
        let sign = (self < 0) ? "-" : "" /* 563 */
        
        switch num{ /* 563 */
        case 1000000000000...: // trillions /* 563 */
            let formatted = num / 1000000000000 /* 563 */
            print(num) /* 563 */
            let stringFormatted = formatted.asNumberString() /* 563 */
            return "\(sign)\(stringFormatted)Tr" /* 563 */
        case 1_000_000_000...: /* 563 */
            let formatted = num / 1_000_000_000 /* 563 */
            let stringFormatted = formatted.asNumberString() /* 563 */
            return "\(sign)\(stringFormatted)Bn" /* 563 */
        case 1_000_000...: /* 563 */
            let formatted = num / 1_000_000 /* 563 */
            let stringFormatted = formatted.asNumberString() /* 563 */
            return "\(sign)\(stringFormatted)M" /* 563 */
        case 1_000...: /* 563 */
            let formatted = num / 1_000 /* 563 */
            let stringFormatted = formatted.asNumberString() /* 563 */
            return "\(sign)\(stringFormatted)K" /* 563 */
        case 0...: /* 563 */
            return self.asNumberString() /* 563 */
        default: /* 563 */
            return "\(sign)\(self)" /* 563 */
        }
    }
    
}
