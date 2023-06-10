//
//  PreviewProvider.swift
//  swiftCoin
//
//  Created by Johel Zarco on 13/12/22.
//

import Foundation
import SwiftUI

extension PreviewProvider{ /* 565 */
    static var dev : DeveloperPreview{ /* 565 */
        return DeveloperPreview.instance /* 565 */
    }
}

class DeveloperPreview{ /* 565 */
    static let instance = DeveloperPreview() /* 565 */
    
//    let stat1 = StatiscticModel(title: "Overview", value: "99.99", percentageChange: "23.69")  // it's NOT recognized by the compiler
}
