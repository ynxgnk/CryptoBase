//
//  StatisticModel.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 13/12/22.
//

import Foundation

struct StatiscticModel : Identifiable{ /* 579 */
    
    let id = UUID().uuidString /* 579 */
    let title : String /* 579 */
    let value : String /* 579 */
    let percentageChange : Double? /* 579 */
}
