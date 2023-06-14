//
//  SettingsViewController.swift
//  CryptoBase
//
//  Created by Nazar Kopeika on 14.06.2023.
//

import StoreKit /* 607 */
import SafariServices /* 607 */
import SwiftUI /* 607 */
import UIKit
/// Controller to show and search for settings
final class SettingsViewController: UIViewController { /* 607 */
    
    private var settingsSwiftUIController: UIHostingController<SettingsView>? /* 607 */ /* 607 UIHostingController?*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 607 */
        title = "Settings" /* 607 */
        addSwiftUIController() /* 607 */
    }
    
    private func addSwiftUIController() { /* 607 */
        let settingsSwiftUIController = UIHostingController(
            rootView: SettingsView(
                viewModel: SettingsViewViewModel( /* 607 */
                    cellViewModels: SettingsOption.allCases.compactMap({ /* 607 it will loop over all cases */
                        return SettingsCellViewModel(type: $0) { [weak self] option in /* 607 */ /* 607 add option in */ /* 607 add weak self */
                            self?.handleTap(option: option) /* 607 */
                        }
                    })
                )
            )
        ) /* 607 */
        addChild(settingsSwiftUIController) /* 607 */
        settingsSwiftUIController.didMove(toParent: self) /* 607 */
    
        view.addSubview(settingsSwiftUIController.view) /* 607 */
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false /* 607 */
        
        NSLayoutConstraint.activate([ /* 607 */
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), /* 607 */
            settingsSwiftUIController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor), /* 607 */
            settingsSwiftUIController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor), /* 607 */
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), /* 607 */
        ])
        
        self.settingsSwiftUIController = settingsSwiftUIController /* 607 */
    }
    
    private func handleTap(option: SettingsOption) { /* 607 */
        guard Thread.current.isMainThread else { /* 607 to be sure that when we do a UI interaction, this function will always be called on the main thread */
        return /* 607 */
        }
        
        if let url = option.targetUrl { /* 607 */
            //open website
            let vc = SFSafariViewController(url: url) /* 607 */
            present(vc, animated: true) /* 607 */
        } else if option == .rateApp { /* 607 */
            //Show rating prompt
                if let windowScene = self.view.window?.windowScene { /* 607 */
                    SKStoreReviewController.requestReview(in: windowScene) /* 607 */
            }
        }
    }
}



