//
//  Color.swift
//  swiftCoin
//
//  Created by Johel Zarco on 09/12/22.
//

import Foundation
import SwiftUI
// to avoid mispelling color

extension Color{ /* 564 */
    static let theme = ColorTheme() /* 564 */
}

struct ColorTheme{ /* 564 */
    let primaryColor = Color("PrimaryTextColor") /* 564 */
    let itemBackgroundColor = Color("ItemBackgroundColor") /* 564 */
}
