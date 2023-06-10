//
//  ViewPostsViewController.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//

import UIKit

class PostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate { /* 592 add 2 protocols */

    private let post: BlogPost /* 592 */
    private let isOwnedByCurrentUser: Bool /* 592 */
    
    init(post: BlogPost, isOwnedByCurrentUser: Bool = false) { /* 592 */ /* 592 add isOwned */
        self.post = post /* 592 */
        self.isOwnedByCurrentUser = isOwnedByCurrentUser /* 592 */
        super.init(nibName: nil, bundle: nil) /* 592 */
    }
    
    required init?(coder: NSCoder) { /* 592 */
        fatalError() /* 592 */
    }
    
    private let tableView: UITableView = { /* 592 */
       //title, header. body
        //poster
        let table = UITableView() /* 592 */
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell") /* 592 */
        table.register(PostHeaderTableViewCell.self,
                       forCellReuseIdentifier: PostHeaderTableViewCell.identifier) /* 592 */
        return table /* 592 */
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 592 */
        view.addSubview(tableView) /* 592 */
        tableView.delegate = self /* 592 */
        tableView.dataSource = self /* 592 */
        
        if !isOwnedByCurrentUser { /* 592 */
            IAPManager.shared.logPostViewed() /* 592 */
        }
    }
    
    override func viewDidLayoutSubviews() { /* 592 */
        super.viewDidLayoutSubviews() /* 592 */
        tableView.frame = view.bounds /* 592 */
    }
    
    //Table
    
    func numberOfSections(in tableView: UITableView) -> Int { /* 592 */
        return 1 /* 592 */
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 592 */
        return 3 // title, image, text /* 592 */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 592 */
        let index = indexPath.row /* 859204 */
        switch index { /* 592 */
        case 0: /* 592 */
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) /* 592 */
            cell.selectionStyle = .none /* 592 */
            cell.textLabel?.numberOfLines = 0 /* 592 */
            cell.textLabel?.font = .systemFont(ofSize: 25, weight: .bold) /* 592 */
            cell.textLabel?.text = post.title /* 592 */
            return cell /* 592 */
        case 1: /* 592 */
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostHeaderTableViewCell.identifier,
                                                           for: indexPath) as? PostHeaderTableViewCell else { /* 592 */
                fatalError() /* 592 */
            }
            cell.selectionStyle = .none /* 592 */
            cell.configure(with: .init(imageUrl: post.headerImageUrl)) /* 592 */
            return cell /* 592 */
        case 2: /* 592 */
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) /* 592 */
            cell.selectionStyle = .none /* 592 */
            cell.textLabel?.numberOfLines = 0 /* 592 */
            cell.textLabel?.text = post.text /* 592 */
            return cell /* 592 */
        default: /* 592 */
            fatalError() /* 592 */
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { /* 592 */
        let index = indexPath.row /* 592 copy from 592 and paste */
        switch index { /* 592 */
        case 0: /* 592 */
            return UITableView.automaticDimension /* 592 */
        case 1: /* 592 */
            return 150 /* 592 */
        case 2: /* 592 */
            return UITableView.automaticDimension /* 592 will automaticly size itself */
        default: /* 592 */
            return UITableView.automaticDimension /* 592 */
        }
    }
}
