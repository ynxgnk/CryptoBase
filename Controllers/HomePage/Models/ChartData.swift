//
//  ChartData.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 14/12/22.
//

import Foundation

struct ChartData : Identifiable{ /* 580 */
    let id = UUID().uuidString /* 580 */
    let date : Date /* 580 */
    let value : Double /* 580 */
}
