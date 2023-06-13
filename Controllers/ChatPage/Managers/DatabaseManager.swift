//
//  DatabaseManager.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//



import Foundation
import FirebaseFirestore /* 582 */
import FirebaseDatabase

final class DatabaseManager { /* 582 */
    static let shared = DatabaseManager() /* 582 */
    
    private let database = Firestore.firestore() /* 582 */
    
    private init() {} /* 582 */
    
    public func insert(
        blogPost: BlogPost, /* 582 change from String to BlogPost */
        email: String, /* 582 change from String */ /* 582 change user: User */
        completion: @escaping (Bool) -> Void
    ) { /* 582 */
        let userEmail = email /* 582 copy from 397 and paste */
            .replacingOccurrences(of: ".", with: "_") /* 582 */
            .replacingOccurrences(of: "@", with: "_") /* 582 */
        
        let data: [String: Any] = [ /* 582 */
            "id": blogPost.identifier,
            "title": blogPost.title,
            "body": blogPost.text,
            "created": blogPost.timestamp,
            "headerImageUrl": blogPost.headerImageUrl?.absoluteString ?? ""
        ]
        
        database
            .collection("users") /* 582 */
            .document(userEmail) /* 582 */
            .collection("posts") /* 582 */
            .document(blogPost.identifier) /* 582 */
            .setData(data) { error in /* 582 */ /* 582 change .addDocument to setData */
                completion(error == nil) /* 582 */
            }
    }
    
    public func getAllPosts(
        completion: @escaping ([BlogPost]) -> Void /* 582 change from String to BlogPost */
    ) { /* 582 */
       // Get all users
        //from each user. get posts

        database
            .collection("users") /* 582 */
            .getDocuments { [weak self] snapshot, error in /* 582 */ /* 582 add weak self */
                guard let documents = snapshot?.documents.compactMap({ $0.data() }), /* 582 */
                      error == nil else { /* 582 */
                    return /* 582 */
                }
                
                let emails: [String] = documents.compactMap({ $0["email"] as? String }) /* 582 */
                print(emails) /* 582 */
                guard !emails.isEmpty else { /* 582 */
                    completion([]) /* 582 */
                    return /* 582 */
                }
                
                let group = DispatchGroup() /* 582 */
                var  result: [BlogPost] = [] /* 582 */

                for email in emails { /* 582 */
                    group.enter() /* 582 */
                    self?.getPosts(for: email) { userPosts in /* 582 */
                        defer { /* 582 */
                            group.leave() /* 582 */
                        }
                        result.append(contentsOf: userPosts) /* 582 */
                    }
                }
                
                group.notify(queue: .global()) { /* 582 */
                    print("Feed posts: \(result.count)") /* 582 */
                    completion(result) /* 582 */
                }
            }
    }
    
    public func getPosts(
        for email: String, /* 582 change from String to User */ /* 582 change user: User to email: String */
        completion: @escaping ([BlogPost]) -> Void /* 582 change from Bool to [BlogPost] */
    ) { /* 582 */
        let userEmail = email /* 582 copy from 582 and paste */
            .replacingOccurrences(of: ".", with: "_") /* 582 */
            .replacingOccurrences(of: "@", with: "_") /* 582 */
        database
            .collection("users") /* 582 */
            .document(userEmail) /* 582 */
            .collection("posts") /* 582 */
            .getDocuments { snapshot, error in /* 582 */
                guard let documents = snapshot?.documents.compactMap ({ $0.data() }),
                      error == nil else { /* 582 */
                    return /* 582 */
                }
                
                let posts: [BlogPost] = documents.compactMap({ dictionary in /* 582 */
                    guard let id = dictionary["id"] as? String, /* 582 */
                    let title = dictionary["title"] as? String, /* 582 */
                        let body = dictionary["body"] as? String, /* 582 */
                        let created = dictionary["created"] as? TimeInterval, /* 582 */
                        let imageUrlString = dictionary["headerImageUrl"] as? String else { /* 582 */
                            print("Invalid post fetch conversion")
                            return nil /* 582 */
                        }
                    
                    let post = BlogPost(
                        identifier: id,
                        title: title,
                        timestamp: created,
                        headerImageUrl: URL(string: imageUrlString),
                        text: body
                    ) /* 582 */
                    return post /* 582 */
                })
                completion(posts) /* 582 */
            }
    }
    
    public func insert(
        user: User, /* 582 change from Bool to User */
        completion: @escaping (Bool) -> Void
    ) { /* 582 */
        let documentId = user.email /* 582 */
            .replacingOccurrences(of: ".", with: "_") /* 582 */
            .replacingOccurrences(of: "@", with: "_") /* 582 */
        
        let data = [ /* 582 */
            "email": user.email,
            "name": user.name
        ]
        
        database
            .collection("users") /* 582 */
            .document(documentId) /* 582 */
            .setData(data) { error in /* 582 */
                completion(error == nil) /* 582 */
            }
    }
    
    public func getUser(
        email: String,
        completion: @escaping (User?) -> Void
    ) { /* 582 */
        let documentId = email /* 582 copy from 582 and paste */
            .replacingOccurrences(of: ".", with: "_") /* 582 */
            .replacingOccurrences(of: "@", with: "_") /* 582 */
        
        database
            .collection("users") /* 582 copy from 582 and paste */
            .document(documentId) /* 582 */
            .getDocument { snapshot, error in /* 582 */
                guard let data = snapshot?.data() as? [String: String],
                      let name = data["name"], /* 582 */
                      error == nil else { /* 582 */
                    return /* 582 */
                }
                
                
                var ref = data["profile_photo"] /* 582 */
                let user = User(name: name, email: email, profilePictureRef: ref) /* 582 */
                completion(user) /* 582 */
            }
    }
    
    func updateProfilePhoto(
        email: String,
        completion: @escaping (Bool) -> Void
    ) { /* 582 */
        let path = email
            .replacingOccurrences(of: "@", with: "_") /* 582 */
            .replacingOccurrences(of: ".", with: "_") /* 582 */
        
        let photoReference = "profile_pictures/\(path)/photo.png" /* 582 */
        
        let dbRef = database
            .collection("users") /* 582 */
            .document(path) /* 582 */
        
        dbRef.getDocument { snapshot, error in /* 582 */
            guard var data = snapshot?.data(), error == nil else { /* 582 */
                return /* 582 */
            }
            
            data["profile_photo"] = photoReference /* 582 */
            
            dbRef.setData(data) { error in /* 582 */
                completion(error == nil) /* 582 */
            }
        }
    }
    
    
    


}


/*

//
//  DatabaseManager.swift
//  Thoughts
//
//  Created by Afraz Siddiqui on 7/11/21.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
    static let shared = DatabaseManager()

    private let database = Firestore.firestore()

    private init() {}

    public func insert(
        blogPost: BlogPost,
        email: String,
        completion: @escaping (Bool) -> Void
    ) {
        let userEmail = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")

        let data: [String: Any] = [
            "id": blogPost.identifier,
            "title": blogPost.title,
            "body": blogPost.text,
            "created": blogPost.timestamp,
            "headerImageUrl": blogPost.headerImageUrl?.absoluteString ?? ""
        ]

        database
            .collection("users")
            .document(userEmail)
            .collection("posts")
            .document(blogPost.identifier)
            .setData(data) { error in
                completion(error == nil)
            }
    }

    public func getAllPosts(
        completion: @escaping ([BlogPost]) -> Void
    ) {
        database
            .collection("users")
            .getDocuments { [weak self] snapshot, error in
                guard let documents = snapshot?.documents.compactMap({ $0.data() }),
                      error == nil else {
                    return
                }

                let emails: [String] = documents.compactMap({ $0["email"] as? String })
                print(emails)
                guard !emails.isEmpty else {
                    completion([])
                    return
                }

                let group = DispatchGroup()
                var result: [BlogPost] = []

                for email in emails {
                    group.enter()
                    self?.getPosts(for: email) { userPosts in
                        defer {
                            group.leave()
                        }
                        result.append(contentsOf: userPosts)
                    }
                }

                group.notify(queue: .global()) {
                    print("Feed posts: \(result.count)")
                    completion(result)
                }
            }
    }

    public func getPosts(
        for email: String,
        completion: @escaping ([BlogPost]) -> Void
    ) {
        let userEmail = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        database
            .collection("users")
            .document(userEmail)
            .collection("posts")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents.compactMap({ $0.data() }),
                      error == nil else {
                    return
                }

                let posts: [BlogPost] = documents.compactMap({ dictionary in
                    guard let id = dictionary["id"] as? String,
                          let title = dictionary["title"] as? String,
                          let body = dictionary["body"] as? String,
                          let created = dictionary["created"] as? TimeInterval,
                          let imageUrlString = dictionary["headerImageUrl"] as? String else {
                        print("Invalid post fetch conversion")
                        return nil
                    }

                    let post = BlogPost(
                        identifier: id,
                        title: title,
                        timestamp: created,
                        headerImageUrl: URL(string: imageUrlString),
                        text: body
                    )
                    return post
                })

                completion(posts)
            }
    }

    public func insert(
        user: User,
        completion: @escaping (Bool) -> Void
    ) {
        let documentId = user.email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")

        let data = [
            "email": user.email,
            "name": user.name
        ]

        database
            .collection("users")
            .document(documentId)
            .setData(data) { error in
                completion(error == nil)
            }
    }

    public func getUser(
        email: String,
        completion: @escaping (User?) -> Void
    ) {
        let documentId = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")

        database
            .collection("users")
            .document(documentId)
            .getDocument { snapshot, error in
                guard let data = snapshot?.data() as? [String: String],
                      let name = data["name"],
                      error == nil else {
                    return
                }

                let ref = data["profile_photo"]
                let user = User(name: name, email: email, profilePictureRef: ref)
                completion(user)
            }
    }

    func updateProfilePhoto(
        email: String,
        completion: @escaping (Bool) -> Void
    ) {
        let path = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")

        let photoReference = "profile_pictures/\(path)/photo.png"

        let dbRef = database
            .collection("users")
            .document(path)

        dbRef.getDocument { snapshot, error in
            guard var data = snapshot?.data(), error == nil else {
                return
            }
            data["profile_photo"] = photoReference

            dbRef.setData(data) { error in
                completion(error == nil)
            }
        }

    }
}

*/
