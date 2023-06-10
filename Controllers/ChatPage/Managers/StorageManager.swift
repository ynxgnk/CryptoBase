//
//  StorageManager.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//

import Foundation
import FirebaseStorage /* 584 */

final class StorageManager { /* 584 */
    static let shared = StorageManager() /* 584 */
    
    private let container = Storage.storage() /* 584 */ /* 584 add reference() gives a reference to storage */ /* 584 remove .reference() */
    
    private init() {} /* 584 */
    
    public func uploadUserProfilePicture(
        email: String,
        image: UIImage?,
        completion: @escaping (Bool) -> Void
    ) { /* 584 */
        let path = email
            .replacingOccurrences(of: "@", with: "_") /* 584 */
            .replacingOccurrences(of: ".", with: "_") /* 584 */
        
        guard let pngData = image?.pngData() else { /* 584 */
            return /* 584 */
        }
        
        container
            .reference(withPath: "profile_pictures/\(path)/photo.png") /* 584 */
            .putData(pngData, metadata: nil) { metadata, error in /* 584 */
                guard metadata != nil, error == nil else { /* 584 */
                    completion(false) /* 584 */
                    return /* 584 */
                }
                completion(true) /* 584 */
            }
    }
    
    public func downloadUrlForProfilePicture(
//        user: User,
        path: String, /* 584 */
        completion: @escaping (URL?) -> Void
    ) { /* 584 */
        container.reference(withPath: path) /* 584 */
            .downloadURL { url, _ in /* 584 */
                completion(url) /* 584 */
            }
    }
    
    public func uploadBlogHeaderImage(
        email: String, /* 584 add email */
        image: UIImage,
        postId: String,
        completion: @escaping (Bool) -> Void
    ) { /* 584 */
        let path = email
            .replacingOccurrences(of: "@", with: "_") /* 584 copy from 584 and paste */
            .replacingOccurrences(of: ".", with: "_") /* 584 */
        
        guard let pngData = image.pngData() else { /* 584 */
            return /* 584 */
        }
        
        container
            .reference(withPath: "post_headers/\(path)/\(postId).png") /* 584 */
            .putData(pngData, metadata: nil) { metadata, error in /* 584 */
                guard metadata != nil, error == nil else { /* 584 */
                    completion(false) /* 584 */
                    return /* 584 */
                }
                completion(true) /* 584 */
            }
    }
    
    public func downloadUrlForPostHeader(
        email: String,
        postId: String,
        completion: @escaping (URL?) -> Void
    ) { /* 584 */
        let emailComponent = email
            .replacingOccurrences(of: "@", with: "_") /* 584 copy from 584 and paste */
            .replacingOccurrences(of: ".", with: "_") /* 584 */
        
        container
            .reference(withPath: "post_headers/\(emailComponent)/\(postId).png") /* 584 */
            .downloadURL { url, _ in /* 584 */
                completion(url) /* 584 */
            }
    }
}
