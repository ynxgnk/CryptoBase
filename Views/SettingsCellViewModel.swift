//
//  SettingsCellViewModel.swift
//  CryptoBase
//
//  Created by Nazar Kopeika on 14.06.2023.
//

//
//  RMSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Nazar Kopeyka on 29.03.2023.
//

import UIKit /* 609 UIKit */

struct SettingsCellViewModel: Identifiable { /* 609 */ /* 609 add Identifiable and Hashable */
    let id = UUID() /* 609 will create a unique ID for each of viewModel instances we create */ /* 609 remove Hashable */
   
    public let type: SettingsOption /* 609 */
    public let onTapHandler: (SettingsOption) -> Void /* 609 */
    //MARK: - Init
    
    init(type: SettingsOption, onTapHandler: @escaping (SettingsOption) -> Void) { /* 609 */ /* 609 add ontapHandler */
        self.type = type /* 609 */
        self.onTapHandler = onTapHandler /* 609 */
    }
    
    //MARK: - Public
    
    public var image: UIImage? { /* 609 */
        return type.iconImage /* 609 */
    }
    
    public var title: String { /* 609 */
        return type.displayTitle /* 609 */
    }
    
    public var iconContainerColor: UIColor { /* 609 */
        return type.iconContainerColor /* 609 */
    }
}
