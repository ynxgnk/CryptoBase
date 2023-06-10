//
//  PayWallViewController.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//

import UIKit

class PayWallViewController: UIViewController {

    private let header = PayWallHeaderView() /* 588 */
    //Close button / Title
    //Pricing and product info
    private let heroView = PayWallDescriptionView() /* 588 */
    
    //Called Action Button
    private let buyButton: UIButton = { /* 588 */
        let button = UIButton() /* 588 */
        button.setTitle("Subscribe", for: .normal) /* 588 */
        button.backgroundColor = .systemBlue /* 588 */
        button.setTitleColor(.white, for: .normal) /* 588 */
        button.layer.cornerRadius = 8 /* 588 */
        button.layer.masksToBounds = true /* 588 */
        return button /* 588 */
    }()
    
    private let restoreButton: UIButton = { /* 176 */
        let button = UIButton() /* 588 */
        button.setTitle("Restore Purchases", for: .normal) /* 588 */
        button.setTitleColor(.link, for: .normal) /* 588 */
        button.layer.cornerRadius = 8 /* 588 */
        button.layer.masksToBounds = true /* 588 */
        return button /* 588 */
    }()
    
    //Terms of Service
    private let termsView: UITextView = { /* 588 */
        let textView = UITextView() /* 588 */
        textView.isEditable = false /* 588 */
        textView.textAlignment = .center /* 588 */
        textView.textColor = .secondaryLabel /* 588 */
        textView.font = .systemFont(ofSize: 14) /* 588 */
        textView.text = "This is an auto-renewable Subscription. It will be charged to your iTunes account before each pay period. You can cancel anytime by going into your Settings > Subscriptions. Restore purchases if previously subscribed." /* 588 */
        return textView /* 588 */
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CryptoBase Premium" /* 588 */
        view.backgroundColor = .systemBackground /* 588 */
        view.addSubview(header) /* 588 */
        view.addSubview(buyButton) /* 588 */
        view.addSubview(restoreButton) /* 588 */
        view.addSubview(termsView) /* 588 */
        view.addSubview(heroView) /* 588 */
        setUpCloseButton() /* 588 */
        setUpButtons() /* 588 */
//        heroView.backgroundColor = .systemYellow /* 588 */
    }
    
    override func viewDidLayoutSubviews() { /* 588 */
        super.viewDidLayoutSubviews() /* 588 */
        header.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: view.height / 3.2
        ) /* 588 */
        
        termsView.frame = CGRect(
            x: 10,
            y: view.height - 120,
            width: view.width - 20,
            height: 100
        ) /* 588 */
        
        restoreButton.frame = CGRect(
            x: 25,
            y: termsView.top - 70,
            width: view.width - 50,
            height: 50
        ) /* 588 */
        
        buyButton.frame = CGRect(
            x: 25,
            y: restoreButton.top - 60,
            width: view.width - 50,
            height: 50
        ) /* 588 */
        
        heroView.frame = CGRect(
            x: 0,
            y: header.bottom,
            width: view.width,
            height: buyButton.top - view.safeAreaInsets.top - header.height
        ) /* 588 */
    }
    
    private func setUpButtons() { /* 588 */
        buyButton.addTarget(self, action: #selector(didTapSubscribe), for: .touchUpInside) /* 588 */
        restoreButton.addTarget(self, action: #selector(didTapRestore), for: .touchUpInside) /* 588 */
    }
    
    @objc private func didTapSubscribe() { /* 588 */
        IAPManager.shared.fetchPackages { package in /* 588 */
            guard let package = package else { return } /* 588 */
            IAPManager.shared.subscribe(package: package) { [weak self] success in /* 588 */ /* 588 add weak self */
                print("Purchase: \(success)") /* 588 */
                DispatchQueue.main.async { /* 588 */
                    if success { /* 588 */
                        self?.dismiss(animated: true, completion: nil) /* 588 */
                    } else { /* 588 */
                        let alert = UIAlertController(
                            title: "Subscription Failed",
                            message: "We were unable to complete the transaction.",
                            preferredStyle: .alert
                        ) /* 588 */
                        alert.addAction(UIAlertAction(
                            title: "Dismiss",
                            style: .cancel,
                            handler: nil)
                        ) /* 588 */
                        self?.present(alert, animated: true, completion: nil) /* 588 */
                    }
                }
            }
        }
    }
    
    /* IAPManager.shared.fetchPackages { package in /* 588 */
     guard let package = package else { /* 588 */
         return /* 588 */
     }
     print("Got package!") /* 588 */
     IAPManager.shared.subscribe(package: package) { success in /* 588 */
         print("Success: \(success)") /* 588 */
     }
 }
     */
    
    @objc private func didTapRestore() { /* 588 */
        IAPManager.shared.restorePurchases { [weak self] success in /* 588 */
            print("Restored: \(success)") /* 588 copy from didTapSubscribe 588 */
            DispatchQueue.main.async { /* 588 */
                if success { /* 588 */
                    self?.dismiss(animated: true, completion: nil) /* 588 */
                } else { /* 588 */
                    let alert = UIAlertController(
                        title: "Restoration Failed",
                        message: "We were unable to restore a previous transaction.",
                        preferredStyle: .alert
                    ) /* 588 */
                    alert.addAction(UIAlertAction(
                        title: "Dismiss",
                        style: .cancel,
                        handler: nil)
                    ) /* 588 */
                    self?.present(alert, animated: true, completion: nil) /* 588 */
                }
            }
        }
    }
    
    private func setUpCloseButton() { /* 588 */
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapClose)
        ) /* 588 */
    }
    
    @objc private func didTapClose() { /* 588 */
        dismiss(animated: true, completion: nil) /* 588 */
    }
    

}
