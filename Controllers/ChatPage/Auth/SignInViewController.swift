//
//  SignInViewController.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//

import UIKit
import FirebaseAuth

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

///

/*

extension SignInViewController: UITextFieldDelegate { /* 94 */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { /* 95 go button */
        
        if textField == emailField { /* 97 */
            passwordField.becomeFirstResponder() /* 98 */
        } else if textField == passwordField { /* 99 */
            didTapSignIn() /* 100 */
        }
        return true /* 96 */
    }
}

extension SignInViewController: LoginButtonDelegate { /* 285 */
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        // no operation
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) { /* 286 */
        guard let token = result?.token?.tokenString else { /* 287 */
            print("User failed to log in with facebook") /* 288 */
            return /* 289 */
        }
        
        let facebookRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                         parameters: ["fields":
                                                                        "email, first_name, last_name, picture.type(large)"], /* 489 add first_name, last_name and picture */
                                                         tokenString: token,
                                                         version: nil,
                                                         httpMethod: .get) /* 305 */
        
        facebookRequest.start(completion: { _, result, error in /* 306 */
            guard let result = result as? [String: Any],
                  error == nil else { /* 307 */
                print("Failed to make facebook graph request") /* 309 */
                return /* 308 */
            }
            
            print(result) /* 310 */ /* 492 change \(result) */
            
            guard let firstName = result["first_name"] as? String, /* 490 change userName */
                  let lastName = result["last_name"] as? String,  /* 491 add lastName */
                  let email = result["email"] as? String,
                  let picture = result["picture"] as? [String: Any],  /* 495 add picture */
                  let data = picture["data"] as? [String: Any], /* 496 add data */
                  let pictureUrl = data["url"] as? String  else { /* 311 */ /* 494 add picture */
                print("Failed to get email and name from fb result") /* 312 */
                return /* 313 */
            }
            
            UserDefaults.standard.set(email, forKey: "email") /* 507 */
            UserDefaults.standard.set("\(firstName) \(lastName)", forKey: "name") /* 927 */
            
            //            let nameComponents = userName.components(separatedBy: " ") /* 314 */
            //            guard nameComponents.count == 2 else { /* 315 */
            //                return /* 316 */
            //            }
            //            let firstName = nameComponents[0] /* 317 */
            //            let lastName = nameComponents[1] /* 318 */
            let chatUser = User(name: firstName,
                                email: email,
                                profilePictureRef: pictureUrl)
            
            DatabaseManager.shared.insert(user: chatUser) { success in
                
                if success {
                    guard let url = URL(string: pictureUrl) else {
                        return
                    }
                    
                    print("Downloading data from facebook image")
                    
                    URLSession.shared.dataTask(with: url) { data, _, _ in
                        guard let data = data else {
                            print("failed to get data from facebook")
                            return
                        }
                        
                        print("got data frim FB, uploading...")
                        
                        //Upload imag
                        
                        let fileName = chatUser.profilePictureRef
                        
                        StorageManager.shared.uploadUserProfilePicture(email: email, image: UIImage(named: pictureUrl)) { result in
                            switch result {
                            case success (let downloadUrl):
                                DatabaseManager.updateProfilePhoto(downloadUrl)
                                print(downloadUrl)
                            case .failure(let error):
                                print("Storage manager erro: \(error)")
                                
                            }
                        }
                    }
                
                        
                    }.resume()
                    
                
            }
            
            /*
             
             DatabaseManager.shared.userExists(with: email, completion: { exists in /* 319 */
             if !exists { /* 320 */
             // insert to database
             let chatUser = ChatAppUser(firstName: firstName,
             lastName: lastName,
             emailAdress: email) /* 463 */
             DatabaseManager.shared.insertUser(with: chatUser, completion: { success in /* 321 */ /* 464 change ChatAppUser() to chatUser and add completion */
             if success { /* 480 */
             
             guard let url = URL(string: pictureUrl) else {  /* 497 */
             return  /* 498 */
             }
             
             print("Downloading data from facebook image") /* 502 */
             
             URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in  /* 499 */
             guard let data = data else {  /* 500 */
             print("Failed to get data from facebook") /* 504 */
             return  /* 501 */
             }
             
             print("got data from FB, uploading...") /* 503 */
             
             //Upload image
             let fileName = chatUser.profilePictureFileName /* 481 */
             StorageManager.shared.uploadProfilePicture(with: data, fileName: fileName, completion: { result in /* 482 */
             switch result { /* 483 */
             case .success(let downloadUrl): /* 484 */
             UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url") /* 485 */
             print(downloadUrl) /* 486 */
             case .failure(let error): /* 487 */
             print("Storage manager error: \(error)") /* 488 */
             }
             })
             }).resume() /* 505 */
             }
             })
             }
             })
             
             */
            
            let credential = FacebookAuthProvider.credential(withAccessToken: token) /* 290 */
            FirebaseAuth.Auth.auth().signIn(with: credential, completion: { [weak self] authResult, error in /* 291 */ /* 300 add weak self */
                guard let strongSelf = self else { /* 301 */
                    return /* 302 */
                }
                
                guard authResult != nil, error == nil else { /* 296 */
                    if let error = error { /* 304 */
                        print("Facebook credential login failed, MFA may be needed - \(error)") /* 297 */
                    }
                    return /* 298 */
                }
                
                print("Successfully logged user in") /* 299 */
                strongSelf.navigationController?.dismiss(animated: true, completion: nil) /* 303 */
            })
        })
    }
}
*/
