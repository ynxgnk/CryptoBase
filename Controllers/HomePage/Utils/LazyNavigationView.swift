//
//  LazyNavigationView.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 20/12/22.
//

import Foundation
import SwiftUI

struct LazyNavigationView<Content : View> : View{ /* 562 */
    let build : () -> Content /* 562 */
    
    init(_ build: @autoclosure @escaping() -> Content) { /* 562 */
        self.build = build /* 562 */
    }
    
    var body : Content{ /* 562 */
        build() /* 562 */
    }
}
