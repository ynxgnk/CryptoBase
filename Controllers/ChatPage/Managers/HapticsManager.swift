//
//  HapticsManager.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//

import Foundation
import UIKit /* 585 */

class HapticsManager { /* 585 */
    static let shared = HapticsManager() /* 585 */
    
    private init() {} /* 585 */
    
    func vibrateForSelection() { /* 585 */
        let generator = UISelectionFeedbackGenerator() /* 585 */
        generator.prepare() /* 585 */
        generator.selectionChanged() /* 585 */
    }
    
    func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) { /* 585 */
        let generator = UINotificationFeedbackGenerator() /* 585 */
        generator.prepare() /* 585 */
        generator.notificationOccurred(type) /* 585 */
    }
}
