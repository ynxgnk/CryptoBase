//
//  SignUpViewController.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//

import UIKit

class SignUpViewController: UIViewController {

    //Header View
    private let headerView = SignInHeaderView() /* 591 copy from SignInViewController and paste */
    
    //Name field
    private let nameField: UITextField = { /* 591 */
        let field = UITextField() /* 359173 */
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50)) /* 591 */
        field.leftViewMode = .always /* 591 */
        field.placeholder = "Full Name" /* 591 */
        field.autocorrectionType = .no /* 591 changed */
        field.backgroundColor = .secondarySystemBackground /* 591 */
        field.layer.cornerRadius = 8 /* 591 */
        field.layer.masksToBounds = true /* 591 */
        return field /* 591 */
    }()
    
    //Email field
    private let emailField: UITextField = { /* 591 */
        let field = UITextField() /* 591 */
        field.keyboardType = .emailAddress /* 591 */
        field.autocapitalizationType = .none /* 591 */
        field.autocorrectionType = .no /* 591 */
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50)) /* 591 */
        field.leftViewMode = .always /* 591 */
        field.placeholder = "Email Address" /* 591 */
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
    private let signUpButton: UIButton = { /* 591 */
        let button = UIButton() /* 591 */
        button.backgroundColor = .systemGreen /* 591 */
        button.setTitle("Create Account", for: .normal) /* 591 */
        button.setTitleColor(.white, for: .normal) /* 591 */
        return button /* 591 */
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Account" /* 591 */
        view.backgroundColor = .systemBackground /* 591 */
        view.addSubview(headerView) /* 591 */
        view.addSubview(nameField) /* 591 */
        view.addSubview(emailField) /* 591 */
        view.addSubview(passwordField) /* 591 */
        view.addSubview(signUpButton) /* 591 */
        
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside) /* 591 */
    }
    
    override func viewDidLayoutSubviews() { /* 591 */
        super.viewDidLayoutSubviews() /* 591 */
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height/5) /* 591 */
        
        nameField.frame = CGRect(x: 20, y: headerView.bottom, width: view.width-40, height: 50) /* 591 */
        emailField.frame = CGRect(x: 20, y: nameField.bottom+10, width: view.width-40, height: 50) /* 591 */
        passwordField.frame = CGRect(x: 20, y: emailField.bottom+10, width: view.width-40, height: 50) /* 591 */
        signUpButton.frame = CGRect(x: 20, y: passwordField.bottom+10, width: view.width-40, height: 50) /* 591 */

    }
    
    
    
    @objc func didTapSignUp() { /* 591 */
        guard let email = emailField.text, !email.isEmpty, /* 591 */
              let password = passwordField.text, !password.isEmpty,
              let name = nameField.text, !name.isEmpty else {
            return /* 591 */
        }
        
        HapticsManager.shared.vibrateForSelection() /* 591 */
        
        //Create Account
        AuthManager.shared.signUp(email: email, password: password) { [weak self] success in /* 591 */ /* 591 add weak self */
            if success { /* 591 */
                //Update database
                let newUser = User(name: name, email: email, profilePictureRef: nil) /* 591 */
                DatabaseManager.shared.insert(user: newUser) { inserted in /* 591 */
                    guard inserted else { /* 591 */
                        return /* 591 */
                    }
                    
                    UserDefaults.standard.set(email, forKey: "email") /* 591 */
                    UserDefaults.standard.set(name, forKey: "name") /* 591 */
                    
                    DispatchQueue.main.async { /* 591 */
                        let vc = TabBarViewController() /* 591 */
                        vc.modalPresentationStyle = .fullScreen /* 591 */
                        self?.present(vc, animated: true) /* 591 */
                    }
                }
            } else { /* 591 */
                print("Failed to create account") /* 591 */
            }
        }
        //Update database
    }
    
}
