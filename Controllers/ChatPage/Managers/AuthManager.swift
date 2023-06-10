//
//  AuthManager.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//

import Foundation
import FirebaseAuth /* 583 */

final class AuthManager { /* 583 */
    static let shared = AuthManager() /* 583 */
    
    private let auth = Auth.auth() /* 583 */
    
    private init() {} /* 583 */
    
    public var isSignedIn: Bool { /* 583 */
        return auth.currentUser != nil /* 583 */
    }
    
    public func signUp(
        email: String,
        password: String,
        completion: @escaping (Bool) -> Void
    ) { /* 583 */
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else { /* 583 */
            return /* 583 */
        }
        
        auth.createUser(withEmail: email, password: password) { result, error in /* 583 */
            guard result != nil, error == nil else { /* 583 */
                completion(false) /* 583 */
                return /* 583 */
            }
            
            //Account Created
            completion(true) /* 583 */
        }
    }
    
    public func signIn(
        email: String,
        password: String,
        completion: @escaping (Bool) -> Void
    ) { /* 583 */
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else { /* 583 */
            return /* 583 */
        }
        
        auth.signIn(withEmail: email, password: password) { result, error in /* 583 */
            guard result != nil, error == nil else { /* 583 */
                completion(false) /* 583 */
                return /* 583 */
            }
            
            completion(true) /* 583 */
        } /* 583 */
    }
    
    public func signOut(
        completion: (Bool) -> Void
    ) { /* 583 */
        do { /* 583 */
            try auth.signOut() /* 583 */
            completion(true) /* 583 */
        }
        catch { /* 583 */
            print(error) /* 583 */
            completion(false) /* 583 */
        }
    }
}
