//
//  IAPManager.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//


import Foundation
import Purchases /* 581 */
import StoreKit /* 581 */

final class IAPManager { /* 581 */
    static let shared = IAPManager() /* 581 */
    
    static let formatter = ISO8601DateFormatter() /* 581 */
    
    private var postEligibleViewDate: Date? { /* 581 */
        get { /* 581 */
            guard let string = UserDefaults.standard.string(forKey: "postEligibleViewDate") else { /* 581 */
                return nil /* 581 */
            }
            return IAPManager.formatter.date(from: string) /* 581 */
        }
        set { /* 581 */
            guard let date = newValue else { /* 581 */
                return /* 581 */
            }
            let string = IAPManager.formatter.string(from: date) /* 581 */
            UserDefaults.standard.set(string, forKey: "postEligibleViewDate") /* 581 */
        }
    }
    //9eb0501030a848b2bcd519ef0c3941c0
    
    private init() {} /* 581 */
    
    func isPremium() -> Bool { /* 581 */
//        return false /* 581 */
        return UserDefaults.standard.bool(forKey: "premium") /* 581 */
    }
    
    public func getSubscriptionStatus(completion: ((Bool) -> Void)?) { /* 581 */
        Purchases.shared.purchaserInfo { info, error in /* 581 */
            guard let entitlements = info?.entitlements,
                  error == nil else { /* 581 */
                return /* 581 */
            }
            
            if entitlements.all["Premium"]?.isActive == true { /* 581 */
                print("Got updated status of subscribed") /* 581 */
                UserDefaults.standard.set(true, forKey: "premium") /* 581 */
                completion?(true) /* 581 */
            } else { /* 581 */
                print("Got updated status of NOT subscribed") /* 581 */
                UserDefaults.standard.set(false, forKey: "premium") /* 581 */ //tyt
                completion?(false) /* 581 */ //tyt
            }
//            print(entitlements) /* 581 */
        }
    }
    
    public func fetchPackages(completion: @escaping (Purchases.Package?) -> Void) { /* 581 */
        Purchases.shared.offerings { offerings, error in /* 581 */
            guard let package = offerings?.offering(identifier: "default")?.availablePackages.first, /* 581 */
                  error == nil else {
                completion(nil) /* 581 */
                return
            }
            
            completion(package) /* 581 */
        }
    }
    
    public func subscribe(
        package: Purchases.Package,
        completion: @escaping (Bool) -> Void
    ) { /* 581 */ /* 581 add package: */ /* 581 add completion */
        guard !isPremium() else { /* 581 */
            print("User already subscribed") /* 581 */
            completion(true) /* 581 */
            return /* 581 */
        }
        
        Purchases.shared.purchasePackage(package) { transaction, info, error, userCancelled in /* 581 */
            guard let transaction = transaction,
                  let entitlements = info?.entitlements,
                  error == nil,
                  !userCancelled else { /* 581 */
                return /* 581 */
            }
            
            switch transaction.transactionState { /* 581 */
            case .purchasing: /* 581 */
                print("purchasing") /* 581 */
            case .purchased: /* 581 */
//                UserDefaults.standard.set(true, forKey: "premium") /* 581 */
                if entitlements.all["Premium"]?.isActive == true { /* 581 */
                    print("Purchased!") /* 581 */
                    UserDefaults.standard.set(true, forKey: "premium") /* 581 */
                    completion(true) /* 581 */
                } else { /* 581 */
                    print("Purchased failed") /* 581 */
                    UserDefaults.standard.set(false, forKey: "premium") /* 581 */
                    completion(false) /* 581 */
                }
            case .failed: /* 581 */
                print("failed") /* 581 */
            case .restored: /* 581 */
                print("restore") /* 581 */
            case .deferred: /* 581 */
                print("deferred") /* 581 */
            @unknown default: /* 581 */
                print("default case") /* 581 */
            }
        }
    }
    
    public func restorePurchases(completion: @escaping (Bool) -> Void) { /* 581 */ /* 581 add completion handler */
        Purchases.shared.restoreTransactions { info, error in /* 581 */
            guard let entitlements = info?.entitlements,
                  error == nil else { /* 581 */
                return /* 581 */
            }
//            print("Restored: \(entitlements)") /* 581 */
            if entitlements.all["Premium"]?.isActive == true { /* 581 copy from 581 */
                print("Restored success") /* 581 */
                UserDefaults.standard.set(true, forKey: "premium") /* 581 */
                completion(true) /* 581 */
            } else { /* 277 */
                print("Restored failure") /* 581 */
                UserDefaults.standard.set(false, forKey: "premium") /* 581 */
                completion(false) /* 277 */
            }
        }
    }
}

//MARK: - Track Post Views
extension IAPManager { /* 581 */
    var canViewPost: Bool { /* 581 */
        if isPremium() { /* 581 */
            return true /* 581 */
        }
        guard let date = postEligibleViewDate else { /* 581 */
            return true /* 581 */
        }
        UserDefaults.standard.set(0, forKey: "post_views") /* 581 */
        return Date() >= date /* 581 */
    }
    
    public func logPostViewed() { /* 581 */
        let total = UserDefaults.standard.integer(forKey: "post_views")  /* 581 */
            //            total = count + 1 /* 581 */
            UserDefaults.standard.set(total+1, forKey: "post_views") /* 581 */
            
            if total == 2 { /* 581 */
                let hour: TimeInterval = 60 * 60 /* 581 */
                postEligibleViewDate = Date().addingTimeInterval(hour * 24) /* 581 */
            }
        }
    }
