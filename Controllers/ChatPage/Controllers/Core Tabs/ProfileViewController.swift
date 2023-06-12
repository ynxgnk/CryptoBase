//
//  ProfileViewController.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate { /* 590 add UITableViewDelegate and dataSource */

    //Profile Photo
    
    //Full Name
    
    //Email
    
    //List of posts
    
    private var user: User? /* 590 */
    
    private let tableView: UITableView = { /* 590 */
        let tableView = UITableView() /* 590 */
        tableView.register(PostPreviewTableViewCell.self, /* 590 change UITableViewCell */
                           forCellReuseIdentifier: PostPreviewTableViewCell.identifier) /* 590 */ /* 590 change "cell" */
        return tableView /* 590 */
    }()
    
    let currentEmail: String /* 590 */
    
    init(currentEmail: String) { /* 590 */
        self.currentEmail = currentEmail /* 590 */
        super.init(nibName: nil, bundle: nil) /* 590 */
    }
    
    required init?(coder: NSCoder) { /* 590 */
        fatalError() /* 590 */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 590 */
        setUpSignOutButton() /* 590 */
        setUpTable() /* 590 */
        title = "Profile" /* 590 */
        fetchPosts() /* 590 */
    }
    
    override func viewDidLayoutSubviews() { /* 590 */
        super.viewDidLayoutSubviews() /* 590 */
        tableView.frame = view.bounds /* 590 */
    }
    
    private func setUpTable() { /* 590 */
        view.addSubview(tableView) /* 590 */
        tableView.delegate = self /* 590 */
        tableView.dataSource = self /* 590 */
        setUpTableHeader() /* 590 */
        fetchProfileData() /* 590 */
    }
    
    private func setUpTableHeader(
        profilePhotoRef: String? = nil,
        name: String? = nil
    ) { /* 590 */ /* 590 add profilePhotoUrl, name */ /* 590 change to ...PhotoRef: String? */
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5)) /* 590 */
        headerView.backgroundColor = .systemGray /* 590 */
        headerView.isUserInteractionEnabled = true /* 590 */
        headerView.clipsToBounds = true /* 590 */
        tableView.tableHeaderView = headerView /* 590 */
        
        //Profile picture
        let profilePhoto = UIImageView(image: UIImage(systemName: "person.circle")) /* 590 */
        profilePhoto.tintColor = .white /* 590 */
        profilePhoto.contentMode = .scaleAspectFit /* 590 */
        profilePhoto.frame = CGRect( /* 590 */
            x: (view.width-(view.width/4))/2,
            y: (headerView.height-(view.width/4))/2.5,
            width: view.width/4,
            height: view.width/4
        )
        profilePhoto.layer.masksToBounds = true /* 590 */
        profilePhoto.layer.cornerRadius = profilePhoto.width/2 /* 590 */
        profilePhoto.isUserInteractionEnabled = true /* 590 */
        headerView.addSubview(profilePhoto) /* 590 */
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapProfilePhoto)) /* 590 */
        profilePhoto.addGestureRecognizer(tap) /* 590 */
        
        //Email
        let emailLable = UILabel(frame: CGRect( /* 590 */
            x: 20,
            y: profilePhoto.bottom+10,
            width: view.width-40,
            height: 100))
        headerView.addSubview(emailLable) /* 590 */
        emailLable.text = currentEmail /* 590 */
        emailLable.textAlignment = .center /* 590 */
        emailLable.textColor = .white /* 590 */
        emailLable.font = .systemFont(ofSize: 25, weight: .bold) /* 590 */
        
        //Name
        if let name = name { /* 590 */
            title = name /* 590 */
        }
        
        if let ref = profilePhotoRef { /* 590 */
            //Fetch image
//            print("Found photo ref: \(ref)") /* 590 */
            StorageManager.shared.downloadUrlForProfilePicture(path: ref) { url in /* 590 */
                guard let url = url else { /* 590 */
                    return /* 590 */
                }
                let task = URLSession.shared.dataTask(with: url) { data, _, _ in /* 590 */
                    guard let data = data else { /* 590 */
                        return /* 590 */
                    }
                    DispatchQueue.main.async { /* 590 */
                        profilePhoto.image = UIImage(data: data) /* 590 */
                    }
                }
                
                task.resume() /* 590 */
            }
        }
    }
    
    @objc private func didTapProfilePhoto() { /* 590 */
        guard let myEmail = UserDefaults.standard.string(forKey: "email"),
              myEmail == currentEmail else { /* 590 */
            return /* 590 */
        }
        
        let picker = UIImagePickerController() /* 590 */
        picker.sourceType = .photoLibrary /* 590 */
        picker.delegate = self /* 590 */
        picker.allowsEditing = true /* 590 */
        present(picker, animated: true) /* 590 */
    }
    
    private func fetchProfileData() { /* 590 */
        DatabaseManager.shared.getUser(email: currentEmail) { [weak self] user in /* 590 */ /* 590 add weak self */
            guard let user = user else { /* 590 */
                return /* 590 */
            }
            self?.user = user /* 590 */
            
            DispatchQueue.main.async { /* 590 */
                self?.setUpTableHeader(
                    profilePhotoRef: user.profilePictureRef,
                    name: user.name
                ) /* 590 */
            }
        }
    }
    
    private func setUpSignOutButton() { /* 590 */
        navigationItem.rightBarButtonItem = UIBarButtonItem( /* 590 */
            title: "Sign Out",
            style: .done,
            target: self,
            action: #selector(didTapSignOut)
        )
    }
    
    /// Sign Out
    @objc private func didTapSignOut() { /* 590 */
        let sheet = UIAlertController(title: "Sign Out", message: "Are you sure you'd like to sing out?", preferredStyle: .actionSheet) /* 590 */
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil)) /* 590 */
        sheet.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in /* 590 */
            AuthManager.shared.signOut { [weak self] success in /* 590 */
                if success { /* 590 */
                    DispatchQueue.main.async { /* 590 */
                        UserDefaults.standard.set(nil, forKey: "email") /* 590 */
                        UserDefaults.standard.set(nil, forKey: "name") /* 590 */
                        UserDefaults.standard.set(false, forKey: "premium") /* 590 */
                        
                        let signInVC = SignInViewController() /* 590 */
                        signInVC.navigationItem.largeTitleDisplayMode = .always /* 590 */
                        
                        let navVC = UINavigationController(rootViewController: signInVC) /* 590 */
                        navVC.navigationBar.prefersLargeTitles = true /* 590 */
                        navVC.modalPresentationStyle = .fullScreen /* 590 */
                        self?.present(navVC, animated: true, completion: nil) /* 590 */
                    }
                }
            }
        }))
        present(sheet, animated: true) /* 590 */
    }
    
    //TableView
    
    private var posts: [BlogPost] = [] /* 590 */
    
    private func fetchPosts() { /* 590 */
        
        
        print("Fetching posts...") /* 590 */
        
        DatabaseManager.shared.getPosts(for: currentEmail) { [weak self] posts in /* 590 */
            self?.posts = posts /* 590 */
            print("Found \(posts.count) posts") /* 590 */
            DispatchQueue.main.async { /* 590 */
                self?.tableView.reloadData() /* 590 */
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 590 */
        return posts.count /* 590 */ /* 590 */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 590 */
        let post = posts[indexPath.row] /* 590 */
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostPreviewTableViewCell.identifier, for: indexPath) as? PostPreviewTableViewCell else { /* 590 */
            fatalError() /* 590 */
        }
        cell.configure(with: .init(title: post.title, imageUrl: post.headerImageUrl, description: post.text, currentEmail: currentEmail)) /* 590 to create a  viewModel */ //tyt /* 605 */
//        cell.textLabel?.text = post.title /* 590 */ /* 590 change "Blog post goes here" */
        return cell /* 590 */
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { /* 590 */
        return 200 /* 590 */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 590 */
        tableView.deselectRow(at: indexPath, animated: true) /* 590 */
        
        HapticsManager.shared.vibrateForSelection() /* 590 */
        
        var isOwnedByCurrentUser = false /* 590 */
        if let email = UserDefaults.standard.string(forKey: "email") { /* 590 */
            isOwnedByCurrentUser = email == currentEmail /* 590 */
        }
        
        if !isOwnedByCurrentUser { /* 590 */
            if IAPManager.shared.canViewPost { /* 590 */
                let vc = PostViewController(
                    post: posts[indexPath.row],
                    isOwnedByCurrentUser: isOwnedByCurrentUser,
                    currentEmail: currentEmail
                ) /* 590 copy from 590 and paste */
                vc.navigationItem.largeTitleDisplayMode = .never /* 590 */
                vc.title = "Post" /* 590 */
                navigationController?.pushViewController(vc, animated: true) /* 590 */
            }
            else { /* 590 */
                let vc = PayWallViewController() /* 590 */
                present(vc, animated: true) /* 590 */
            }
        }
        else { /* 590 */
            // Our post
            let vc = PostViewController(
                post: posts[indexPath.row],
                isOwnedByCurrentUser: isOwnedByCurrentUser,
                currentEmail: currentEmail
            ) /* 590 */ /* 590 add post */ /* 590 add isOwned */
    //        vc.title = posts[indexPath.row].title /* 590 */
            vc.navigationItem.largeTitleDisplayMode = .never /* 590 */
            vc.title = "Post" /* 590 */
            navigationController?.pushViewController(vc, animated: true) /* 590 */
        }
    }
        
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationBarDelegate { /* 590 */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) { /* 590 */
        picker.dismiss(animated: true, completion: nil) /* 590 */
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) { /* 590 */
        picker.dismiss(animated: true, completion: nil) /* 590 */
        guard let image = info[.editedImage] as? UIImage else { /* 590 */
            return /* 590 */
        }
        
        StorageManager.shared.uploadUserProfilePicture( /* 590 */
            email: currentEmail,
            image: image
        ) { [weak self] success in /* 590 add weak self */
            guard let strongSelf = self else { return } /* 590 */
            if success {
                //Update database
                DatabaseManager.shared.updateProfilePhoto(email: strongSelf.currentEmail) { updated in /* 590 */
                    guard updated else { /* 590 */
                        return /* 590 */
                    }
                    DispatchQueue.main.async { /* 590 */
                        strongSelf.fetchProfileData() /* 590 */
                    }
                }
            }
        }
    }
}


