//
//  SignInViewController.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//

import UIKit

class SignInViewController: UIViewController {

    //Header View
    private let headerView = SignInHeaderView() /* 591 */
    
    //Email field
    private let emailField: UITextField = { /* 591 */
        let field = UITextField() /* 591 */
        field.keyboardType = .emailAddress /* 591 */
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50)) /* 591 */
        field.leftViewMode = .always /* 591 */
        field.placeholder = "Email Address" /* 591 */
        field.autocapitalizationType = .none /* 591 */
        field.autocorrectionType = .no /* 591 */
        field.backgroundColor = .secondarySystemBackground /* 591 */
        field.layer.cornerRadius = 8 /* 591 */
        field.layer.masksToBounds = true /* 591 */
        return field /* 591 */
    }()
    
    //Password field
    private let passwordField: UITextField = { /* 591 */
        let field = UITextField() /* 591 */
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50)) /* 591 */
        field.leftViewMode = .always /* 591 */
        field.placeholder = "Password" /* 591 */
        field.autocapitalizationType = .none /* 591 */
        field.autocorrectionType = .no /* 591 */
        field.isSecureTextEntry = true /* 591 */
        field.backgroundColor = .secondarySystemBackground /* 591 */
        field.layer.cornerRadius = 8 /* 591 */
        field.layer.masksToBounds = true /* 591 */
        return field /* 591 */
    }()
    
    //Sign In Button
    private let signInButton: UIButton = { /* 591 */
        let button = UIButton() /* 591 */
        button.backgroundColor = .systemBlue /* 591 */
        button.layer.cornerRadius = 8 /* 591 */
        button.setTitle("Sign In", for: .normal) /* 591 */
        button.setTitleColor(.white, for: .normal) /* 591 */
        return button /* 591 */
    }()
    
    //Create Account
    private let createAccountButton: UIButton = { /* 591 */
        let button = UIButton() /* 591 */
        button.setTitle("Create Account", for: .normal) /* 591 */
        button.setTitleColor(.link, for: .normal) /* 591 */
        return button /* 591 */
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Sign In" /* 591 */
        view.backgroundColor = .systemBackground /* 591 */
        view.addSubview(headerView) /* 591 */
        view.addSubview(emailField) /* 591 */
        view.addSubview(passwordField) /* 591 */
        view.addSubview(signInButton) /* 591 */
        view.addSubview(createAccountButton) /* 591 */
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside) /* 591 */
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside) /* 591 */
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+3) { /* 591 */
//            if !IAPManager.shared.isPremium() { /* 591 */
//                let vc = PayWallViewController() /* 591 */
//                let navVC = UINavigationController(rootViewController: vc) /* 591 */
//                self.present(navVC, animated: true, completion: nil) /* 591 */
//            }
//        }
    }
    
    override func viewDidLayoutSubviews() { /* 591 */
        super.viewDidLayoutSubviews() /* 591 */
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height/5) /* 591 */
        
        emailField.frame = CGRect(x: 20, y: headerView.bottom, width: view.width-40, height: 50) /* 591 */
        passwordField.frame = CGRect(x: 20, y: emailField.bottom+10, width: view.width-40, height: 50) /* 591 */
        signInButton.frame = CGRect(x: 20, y: passwordField.bottom+10, width: view.width-40, height: 50) /* 591 */
        createAccountButton.frame = CGRect(x: 20, y: signInButton.bottom+40, width: view.width-40, height: 50) /* 591 */

    }
    
    @objc func didTapSignIn() { /* 591 */
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text,
              !password.isEmpty else { /* 591 */
            return /* 591 */
        }
        
        HapticsManager.shared.vibrateForSelection() /* 591 */
        
        AuthManager.shared.signIn(email: email, password: password) { [weak self] success in /* 591 */ /* 591 add weak self */
            guard success else { /* 591 */
                return /* 591 */
            }
            
            //Update subscription status for newly signed user
            IAPManager.shared.getSubscriptionStatus(completion: nil) /* 591 */
            
            DispatchQueue.main.async { /* 591 */
                UserDefaults.standard.set(email, forKey: "email") /* 591 */
                let vc = TabBarViewController() /* 591 */
                vc.modalPresentationStyle = .fullScreen /* 591 */
                self?.present(vc, animated: true) /* 591 */
            }
        }
    }
    
    
    @objc func didTapCreateAccount() { /* 591 */
        let vc = SignUpViewController() /* 591 */
        vc.title = "Create Account" /* 591 */
        vc.navigationItem.largeTitleDisplayMode = .never /* 591 */
        navigationController?.pushViewController(vc, animated: true) /* 591 */
    }
     
  

}
