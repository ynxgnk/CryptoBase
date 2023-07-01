//
//  swiftCoinApp.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 28/11/22.
//

import SwiftUI

@main
struct swiftCoinApp: App { /* 561 */
    @UIApplicationDelegateAdaptor(AppDelegateWrapper.self) var appDelegate /* 561 */
    var body: some Scene { /* 561 */
        WindowGroup { /* 561 */
            if AuthManager.shared.isSignedIn { /* 561 */
                TabBarView() /* 561 */
            } else { /* 561 */
                SignInView() /* 561 */
            }
        }
    }
}


struct TabBarView: View { /* 561 */
    var body: some View { /* 561 */
            TabBarViewControllerRepresentation() /* 561 */
        }
    }

    
    struct TabBarViewControllerRepresentation: UIViewControllerRepresentable { /* 561 */
        func makeUIViewController(context: Context) -> TabBarViewController { /* 561 */
            TabBarViewController()
        }
        func updateUIViewController(_ uiViewController: TabBarViewController, context: Context) { /* 561 */
            // Можно оставить пустым, если нет необходимости в обновлении контроллера
    }
}

struct SignInView: View { /* 561 */
    var body: some View { /* 561 */
        SignInViewControllerRepresentation() /* 561 */
    }
}

struct SignInViewControllerRepresentation: UIViewControllerRepresentable { /* 561 */
    func makeUIViewController(context: Context) -> SignInViewController { /* 561 */
        SignInViewController() /* 561 */
    }

    func updateUIViewController(_ uiViewController: SignInViewController, context: Context) { /* 561 */
        // Можно оставить пустым, если нет необходимости в обновлении контроллера
    }
}




class TabBarViewController: UITabBarController { /* 561 */
    
    override func viewDidLoad() { /* 561 */
        super.viewDidLoad()
        setUpControllers() /* 561 */
    }
    private func setUpControllers() { /* /* 561 */ */
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "email") else { /* /* 561 */ */
            return /* 561 */
        }
        
        // Set the background color of the tab bar
        tabBar.backgroundImage = UIImage() /* 561 */
        tabBar.shadowImage = UIImage() /* 561 */
        tabBar.backgroundColor = UIColor.systemBackground /* 561 */
        tabBar.tintColor = .label /* 561 */
        
        // Customize the navigation bar appearance
        let appearance = UINavigationBarAppearance() /* 561 */
        appearance.configureWithOpaqueBackground() /* 561 */
        appearance.backgroundColor = UIColor.systemBackground /* 561 */
        appearance.shadowColor = nil /* 561 */
        
        let navigationBar = UINavigationBar.appearance() /* 561 */
        navigationBar.standardAppearance = appearance /* 561 */
        navigationBar.scrollEdgeAppearance = appearance /* 561 */
        
        //        let hostingController = UIHostingController(rootView: homeView)
        
        let homeView = HomeView() /* 561 */
        let hostingController = UIHostingController(rootView: NavigationView { homeView } /* 561 */
            .navigationBarHidden(true)) /* 561 */
        
        let homeVC = UINavigationController(rootViewController: hostingController) /* 561 */
        let newsVC = UINavigationController(rootViewController: NewsViewController()) /* 561 */
        let chatVC = UINavigationController(rootViewController: HomeViewController(currentEmail: currentUserEmail)) /* 561 */ /* 605 */
        let profileVC = UINavigationController(rootViewController: ProfileViewController(currentEmail: currentUserEmail)) /* 561 */
                
        homeVC.navigationItem.largeTitleDisplayMode = .always /* 561 */
        profileVC.navigationItem.largeTitleDisplayMode = .always /* 561 */
        
        homeVC.navigationBar.prefersLargeTitles = true /* 561 */
        profileVC.navigationBar.prefersLargeTitles = true /* 561 */
        
        homeVC.tabBarItem.image = UIImage(systemName: "house") /* 561 */
        newsVC.tabBarItem.image = UIImage(systemName: "newspaper") /* 561 */
        chatVC.tabBarItem.image = UIImage(systemName: "message") /* 561 */
        profileVC.tabBarItem.image = UIImage(systemName: "person") /* 561 */
        
        homeVC.title = "Home" /* 561 */
        newsVC.title = "News" /* 561 */
        chatVC.title = "Posts" /* 561 */
        profileVC.title = "Profile" /* 561 */
        
        setViewControllers([homeVC, newsVC, chatVC, profileVC], animated: true) /* 561 */
    }
}



