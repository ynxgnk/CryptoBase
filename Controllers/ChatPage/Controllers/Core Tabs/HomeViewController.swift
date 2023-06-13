//
//  HomeViewController.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//



import FirebaseAuth
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource { /* 589 add 2 protocols */
    
    private let composeButton: UIButton = { /* 589 */
        let button = UIButton() /* 589 */
        button.backgroundColor = .systemBlue /* 589 */
        button.tintColor = .white /* 589 */
        button.setImage(UIImage(systemName: "square.and.pencil",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium)),
                        for: .normal) /* 589 */
        button.layer.cornerRadius = 30 /* 589 */
        button.layer.shadowColor = UIColor.label.cgColor /* 589 */
        button.layer.shadowOpacity = 0.4 /* 589 */
        button.layer.shadowRadius = 10 /* 589 */
        return button /* 589 */
    }()
    
    let currentEmail: String /* 605 */

    init(currentEmail: String) { /* 605 */
        self.currentEmail = currentEmail /* 605 */
        super.init(nibName: nil, bundle: nil) /* 605 */
    }
    
    required init?(coder: NSCoder) { /* 605 */
        fatalError() /* 605 */
    }
    
    private let tableView: UITableView = { /* 589 copy from 589 and paste */
        let tableView = UITableView() /* 589 */
        tableView.register(PostPreviewTableViewCell.self, /* 589 */
                           forCellReuseIdentifier: PostPreviewTableViewCell.identifier) /* 589 */
        return tableView /* 589 */
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        view.backgroundColor = .systemBackground /* 589 */
        view.addSubview(tableView) /* 589 */ /* 589 */
        view.addSubview(composeButton) /* 589 */
        composeButton.addTarget(self, action: #selector(didTapCreate), for: .touchUpInside) /* 589 */
        tableView.delegate = self /* 589 */
        tableView.dataSource = self /* 589 */
        // Listen for a notification when a new post is added
        NotificationCenter.default.addObserver(self, selector: #selector(handleNewPostAdded), name: NSNotification.Name("NewPostAdded"), object: nil) /* 589 */
        fetchAllPosts() /* 589 */
    }
    
    @objc private func handleNewPostAdded() { /* 589 */
        // Refresh the posts by fetching all posts again
        fetchAllPosts() /* 589 */
    }
    
    override func viewDidLayoutSubviews() { /* 589 */
        super.viewDidLayoutSubviews() /* 589 */
        composeButton.frame = CGRect(x: view.frame.width - 88,
                                     y: view.frame.height - 88 - view.safeAreaInsets.bottom,
                                     width: 60,
                                     height: 60
        ) /* 589 */
        tableView.frame = view.bounds /* 589 */
    }
    
    @objc private func didTapCreate() { /* 589 */
        let vc = CreateNewPostViewController() /* 589 */
        vc.title = "Create Post" /* 589 */
        let navVC = UINavigationController(rootViewController: vc) /* 589 */
        present(navVC, animated: true) /* 589 */
    }
    
    private var posts: [BlogPost] = [] /* 589 copy from ProfileViewController and paste */
    
    private func fetchAllPosts() { /* 589 */
        print("Fetching home feed...") /* 589 */
        
        DatabaseManager.shared.getAllPosts { [weak self] posts in /* 589 */
            self?.posts = posts /* 589 */
            DispatchQueue.main.async {/* 589 */
                self?.tableView.reloadData() /* 589 */
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 589 */
        return posts.count /* 589 */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 589 */
        let post = posts[indexPath.row] /* 589 */
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostPreviewTableViewCell.identifier, for: indexPath) as? PostPreviewTableViewCell else { /* 589 */
            fatalError() /* 589 */
        }
    
        cell.configure(with: .init(title: post.title, imageUrl: post.headerImageUrl, description: post.text, currentEmail: currentEmail))
        return cell /* 589 */
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { /* 589 */
        return 200 /* 589 */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 589 */
        tableView.deselectRow(at: indexPath, animated: true) /* 589 */
        
        HapticsManager.shared.vibrateForSelection() /* 589 */
        
        guard IAPManager.shared.canViewPost else { /* 589 */
            let vc = PayWallViewController() /* 589 */
            present(vc, animated: true, completion: nil) /* 589 */
            return /* 589 */
        }
        
        let vc = PostViewController(post: posts[indexPath.row], currentEmail: currentEmail) /* 589 */
        vc.navigationItem.largeTitleDisplayMode = .never /* 589 */
        vc.title = "Post" /* 589 */
        navigationController?.pushViewController(vc, animated: true) /* 589 */
    }
}
    
    



