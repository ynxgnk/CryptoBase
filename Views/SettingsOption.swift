//
//  SettingsOption.swift
//  CryptoBase
//
//  Created by Nazar Kopeika on 14.06.2023.
//

//
//  RMSettingsOption.swift
//  RickAndMorty
//
//  Created by Nazar Kopeyka on 29.03.2023.
//

import UIKit /* 610 UIKit */

enum SettingsOption: CaseIterable { /* 610 */
    case rateApp /* 610 */
    case contactUs /* 610 */
    case terms /* 610 */
    case privacy /* 610 */
    case apiReference /* 610 */
    case viewCode /* 610 */
    
    var targetUrl: URL? { /* 610 */
        switch self { /* 610 */
        case .rateApp: /* 610 */
            return nil /* 610 */
        case .contactUs: /* 610 */
            return URL(string: "https://www.instagram.com/ynxgnk/") /* 610 */
        case .terms: /* 610 */
            return URL(string: "https://newsapi.org/terms") /* 610 */
        case .privacy: /* 610 */
            return URL(string: "https://newsapi.org/privacy") /* 610 */
        case .apiReference: /* 610 */
            return URL(string: "https://rickandmortyapi.com/documentation/#get-a-single-episode") /* 610 */
        case .viewCode: /* 610 */
            return URL(string: "https://github.com/ynxgnk/CryptoBase") /* 610 */
        }
    }
    
    var displayTitle: String { /* 610 */
        switch self { /* 610 */
        case .rateApp: /* 610 */
            return "Rate App" /* 610 */
        case .contactUs: /* 610 */
            return "Contact Us" /* 610 */
        case .terms: /* 610 */
            return "Terms of Service" /* 610 */
        case .privacy: /* 610 */
            return "Privacy Policy" /* 610 */
        case .apiReference: /* 610 */
            return "API Reference" /* 610 */
        case .viewCode: /* 610 */
            return "View App Code" /* 610 */
        }
    }
    
    var iconContainerColor: UIColor { /* 610 */
        switch self { /* 610 */
        case .rateApp: /* 610 */
            return .systemBlue /* 610 */
        case .contactUs: /* 610 */
            return .systemGreen /* 610 */
        case .terms: /* 610 */
            return .systemRed /* 610 */
        case .privacy: /* 610 */
            return .systemYellow /* 610 */
        case .apiReference: /* 610 */
            return .systemOrange /* 610 */
        case .viewCode: /* 610 */
            return .systemPink /* 610 */
        }
    }
    
    var iconImage: UIImage? { /* 610 */
        switch self { /* 610 */
        case .rateApp: /* 610 */
            return UIImage(systemName: "star.fill") /* 610 */
        case .contactUs: /* 610 */
            return UIImage(systemName: "paperplane") /* 610 */
        case .terms: /* 610 */
            return UIImage(systemName: "doc") /* 610 */
        case .privacy: /* 610 */
            return UIImage(systemName: "lock") /* 610 */
        case .apiReference: /* 610 */
            return UIImage(systemName: "list.clipboard") /* 610 */
        case .viewCode: /* 610 */
            return UIImage(systemName: "hammer.fill") /* 610 */
        }
    }
}
