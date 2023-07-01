//
//  CustomLoadingIndicator.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 20/12/22.
//

import SwiftUI

struct CustomLoadingIndicator: View { /* 562 */
    var body: some View { /* 562 */
        ProgressView() /* 562 */
            .progressViewStyle(.circular) /* 562 */
            .tint(.white) /* 562 */
            .scaleEffect(x: 1.5, y: 1.5, anchor: .center) /* 562 */
            .frame(width: 80, height: 80) /* 562 */
            .background(Color(.systemGray)) /* 562 */
            .cornerRadius(20) /* 562 */
    }
}

//struct CustomLoadingIndicator_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomLoadingIndicator()
//    }
//}
