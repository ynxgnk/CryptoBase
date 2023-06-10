//
//  Extensions.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//

import Foundation
import UIKit /* 586 */

extension UIView { /* 586 */
    var width: CGFloat { /* 586 */
        frame.size.width /* 586 */
    }
    
    var height: CGFloat { /* 586 */
        frame.size.height /* 586 */
    }
    
    var left: CGFloat { /* 586 */
        frame.origin.x /* 586 */
    }
    
    var right: CGFloat { /* 586 */
        left + width /* 586 */
    }
    
    var top: CGFloat { /* 586 */
        frame.origin.y /* 586 */
    }
    
    var bottom: CGFloat { /* 586 */
        top + height /* 586 */
    }
}

//crypto formatter

class Formatters { /* 586 */
    static let cryptoNumberFormatter: NumberFormatter = { /* 586 */
        let formatter = NumberFormatter() /* 586 */
        formatter.locale = .current /* 586 */
        formatter.allowsFloats = true /* 586 */
        formatter.numberStyle = .currency /* 586 */
        formatter.formatterBehavior = .default /* 586 */
        return formatter /* 586 */
    }()
}
