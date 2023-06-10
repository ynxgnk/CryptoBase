//
//  NewsViewController.swift
//  CryptoShield
//
//  Created by Nazar Kopeika on 04.06.2023.
//


import SafariServices /* 233 */
import UIKit

class NewsViewController: UIViewController {
    
    private let newsFeedBar: UITableView = { /* 12 */
        let table = UITableView(frame: .zero, style: .grouped) /* 13 */
        table.register(NewsTableViewCell.self, /* 49 change UITableViewCell */
                       forCellReuseIdentifier: NewsTableViewCell.identifier) /* 14 */ /* 50 change "cell" */
        return table /* 15 */
    }()
    
//    private let homeLogoButton: UIButton = { /* 65 */ перенести в профиль
//       let logo = UIButton() /* 66 */
//        logo.setImage(UIImage(named: "logo"), for: .normal) /* 67 */
//        logo.layer.cornerRadius = 8 /* 68 */
//        logo.contentMode = .scaleAspectFill
//        logo.layer.masksToBounds = true /* 69 */
//        logo.layer.borderWidth = 0 /* 70 */
////        logo.layer.borderColor = UIColor.tertiarySystemBackground.cgColor /* 71 */
//        return logo /* 72 */
//    }()
    
    private var viewModels = [NewsTableViewCellViewModel]() /* 215 */
    private var articles = [NewsTitlesModel]() /* 214 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News" /* 284 */
        view.backgroundColor = .systemBackground /* 1 */
        setUpHomeFeedBar() /* 80 */
        setUpCoinbaseButton() /* 81 */
        fetchTopStories() /* 226 */
    }
    
    func setUpCoinbaseButton() { /* 78 */
        let coinbaseButton = UIBarButtonItem(
            title: "Coinbase",
            style: .plain,
            target: self,
            action: #selector(didTapCoinbaseButton)
        ) /* 75 */
        coinbaseButton.tintColor = UIColor.systemBlue /* 76 */
        navigationItem.leftBarButtonItem = coinbaseButton /* 77 */
        navigationController?.navigationBar.topItem?.rightBarButtonItems = [
//            UIBarButtonItem(
//                image: UIImage(systemName: "message"),
//                style: .done,
//                target: self,
//                action: #selector(didTapChatButton)
//            ),
            UIBarButtonItem(
                barButtonSystemItem: .search,
                target: self,
                action: #selector(didTapSearchButton)
            )
        ] /* 73 */
    }
    
    @objc private func didTapChatButton() { /* 83 */
//        let chatVC = ChatViewController() /* 86 */
//        navigationController?.pushViewController(chatVC, animated: true) /* 87 */
    }
    
    @objc private func didTapSearchButton() { /* 74 */
        let searchVC = SearchNewsViewController() /* 84 */
        navigationController?.pushViewController(searchVC, animated: true) /* 82 */
    }
    
    @objc private func didTapCoinbaseButton() { /* 64 */
        let indexPath = IndexPath(row: 0, section: 0)
        newsFeedBar.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    private func fetchTopStories() { /* 213 */
        NewsAPICaller.shared.getTopStories { [weak self] result in /* 216 */
            switch result { /* 217 */
            case .success(let articles): /* 218 */
                self?.articles = articles /* 219 */
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "No Description",
                        imageURL: URL(string: $0.urlToImage ?? "") /* 221 */
                    )
                }) /* 220 */
                
                DispatchQueue.main.async { /* 222 */
                    self?.newsFeedBar.reloadData() /* 223 */
                }
                
            case .failure(let error): /* 224 */
                print(error) /* 225 */
            }
        }
    }
    
    private func setUpHomeFeedBar() { /* 79 */
        navigationController?.navigationItem.largeTitleDisplayMode = .always /* 76 */
        view.addSubview(newsFeedBar) /* 16 */
        //homeFeedBar.addSubview(homeLogoButton)
        newsFeedBar.delegate = self /* 20 */
        newsFeedBar.dataSource = self /* 21 */
    }
    override func viewDidLayoutSubviews() { /* 17 */
            super.viewDidLayoutSubviews() /* 18 */
            newsFeedBar.frame = view.bounds /* 19 */
            newsFeedBar.backgroundColor = .systemBackground /* 59 */
            //        homeLogoButton.backgroundColor = .red /* 61 */
            navigationController?.navigationBar.barTintColor = .systemBackground /* 285 */
            navigationController?.navigationBar.isTranslucent = true /* 286 */
        }
    }


    //MARK: - Table

    extension NewsViewController: UITableViewDelegate, UITableViewDataSource { /* 22 */
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 24 */
            return viewModels.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 25 */
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier , for: indexPath) as? NewsTableViewCell else { /* 26 */ /* 51 change "cell" */
                fatalError() /* 52 */
            }
            //        cell.textLabel?.text = "Hello" /* 27 */
            cell.backgroundColor = .systemBackground /* 31 */
            cell.configure(with: viewModels[indexPath.row]) /* 227 */
            return cell /* 28 */
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 228 */
            tableView.deselectRow(at: indexPath, animated: true) /* 229 */
            let article = articles[indexPath.row] /* 230 */
            
            guard let url = URL(string: article.url ?? "") else { /* 231 */
                return /* 232 */
            }
            
            let vc = SFSafariViewController(url: url) /* 234 */
            present(vc, animated: true) /* 235 */
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { /* 29 */
            150 /* 30 */
        }
        
        
    }
