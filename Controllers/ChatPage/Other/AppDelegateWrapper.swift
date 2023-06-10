import UIKit
import Purchases /* 587 */
import FirebaseCore /* 587 */

class AppDelegateWrapper: UIResponder, UIApplicationDelegate { /* 587 */
    var window: UIWindow? /* 587 */
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure() /* 587 */
        
//        Purchases.configure(withAPIKey: "appl_sKFVXGUXUGWfQEVraPzrDjNvhrg")
        Purchases.configure(withAPIKey: "appl_QGRXmjDaIivIJVJIjpHixEOdiEW")  /* 587 */
        
        IAPManager.shared.getSubscriptionStatus(completion: nil) /* /* 587 */ as soon as the app launches, want to get the latest status from the revenueCat */

        
        return true
    }
}
