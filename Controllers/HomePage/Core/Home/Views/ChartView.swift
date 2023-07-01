//
//  ChartView.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 15/12/22.
//

import SwiftUI
import Charts /* 577 */

struct ChartView: View { /* 577 */
    let viewModel : CoinDetailsViewModel /* 577 */
    
    var body: some View { /* 577 */
        Chart{ /* 577 */
            ForEach(viewModel.charData){ item in /* 577 */
    
                LineMark(x: .value("Date", item.date), y: .value("Price", item.value)) /* 577 */
                    .interpolationMethod(.cardinal) /* 577 */
                    .foregroundStyle(viewModel.chartLineColor) /* 577 */
        
            } // forE
        } //Chart
        .chartXScale(domain: ClosedRange(uncheckedBounds: (lower: viewModel.startDate, upper: viewModel.endDate))) /* 577 */
        .chartXAxis{ /* 577 */
            AxisMarks(position: .bottom, values: viewModel.xAxisValues){ value in /* 577 */
                AxisGridLine() /* 577 */
                // formatt dates
                AxisValueLabel(){ /* 577 */
                    if let dateValue = value.as(Date.self){ /* 577 */
                        Text(dateValue.asShortDateString()) /* 577 */
                    }
                }
            }
        }
        .chartYScale(domain: ClosedRange(uncheckedBounds: (lower: viewModel.minPrice, upper: viewModel.maxPrice))) /* 577 */
        .chartYAxis{ /* 577 */
            AxisMarks(position: .leading, values: viewModel.yAxisValues){ value in /* 577 */
                AxisGridLine() /* 577 */
                // format yAxis label with double ext method
                AxisValueLabel(){ /* 577 */
                    if let doubleValue = value.as(Double.self){ /* 577 */
                        Text(doubleValue.formattedWithAbbreviations()) /* 577 */
                    }
                } // AxisV
            } // AxisM
        } // ChartYA
    } // someV
}

//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView()
//    }
//}
