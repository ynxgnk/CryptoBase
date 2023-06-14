//
//  SettingsTableViewCell.swift
//  CryptoBase
//
//  Created by Nazar Kopeika on 14.06.2023.
//

import SwiftUI

struct SettingsView: View {
    let viewModel: SettingsViewViewModel /* 608 */
    
    init(viewModel: SettingsViewViewModel) { /* 608 */
        self.viewModel = viewModel /* 608 */
    }
    
    var body: some View {
            List(viewModel.cellViewModels) { viewModel in /* 608 */
                HStack { /* 608 */
                    if let image = viewModel.image { /* 608 */
                        Image(uiImage: image) /* 608 */
                            .resizable() /* 608 */
                            .renderingMode(.template) /* 608 */
                            .foregroundColor(Color.white) /* 608 */
                            .aspectRatio(contentMode: .fit) /* 608 */
                            .frame(width: 20, height: 20) /* 608 */
                            .foregroundColor(Color.red) /* 608 */
                            .padding(8) /* 608 */
                            .background(Color(viewModel.iconContainerColor)) /* 608 */
                            .cornerRadius(6) /* 608 */
                    }
                    Text(viewModel.title) /* 608 */
                        .padding(.leading, 10) /* 608 */
                    
                    Spacer() /* 608 */
                }
                .padding(.bottom, 3) /* 608 */
                .onTapGesture { /* 608 */
                    viewModel.onTapHandler(viewModel.type) /* 608 */
                }
            }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: .init(cellViewModels: SettingsOption.allCases.compactMap({ /* 608 */
            return SettingsCellViewModel(type: $0) { option in /* 608 */ /* 608 add { option in */
                
            }
        })))
    }
}
