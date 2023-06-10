//
//  SearchNewsViewController.swift
//  CryptoShield
//
//  Created by Nazar Kopeika on 04.06.2023.
//

import SafariServices /* 274 */
import UIKit

class SearchNewsViewController: UIViewController {
        
    private let resultsTable: UITableView = { /* 99 */
        let table = UITableView() /* 100 */
        table.register(NewsTableViewCell.self, /* 269 change UITableViewCell */
                       forCellReuseIdentifier: NewsTableViewCell.identifier) /* 101 */ /* 270 change "cell" */
        return table /* 102 */
    }()
    
    private let searchVC = UISearchController(searchResultsController: nil) /* 268 */
    
    private var viewModels = [NewsTableViewCellViewModel]() /* 254 */
    private var articles = [NewsTitlesModel]() /* 253 */

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(resultsTable) /* 103 */
        resultsTable.delegate = self /* 104 */
        resultsTable.dataSource = self /* 105 */
        view.backgroundColor = .systemBackground /* 5 */
        createSearchBar() /* 281 */

        navigationItem.hidesSearchBarWhenScrolling = false /* 142 */

    }
    
    override func viewDidLayoutSubviews() { /* 95 */
        super.viewDidLayoutSubviews() /* 96 */
        resultsTable.frame = view.bounds /* 282 */
    }
    
    
    
    private func createSearchBar() { /* 89 */
        navigationItem.searchController = searchVC /* 90 */
        searchVC.searchBar.delegate = self /* 283 */
        searchVC.searchBar.placeholder = "Search for news..." /* 97 */
        searchVC.searchBar.searchBarStyle = .minimal /* 98 */
    }
}

//MARK: - TableView

extension SearchNewsViewController: UITableViewDelegate, UITableViewDataSource { /* 94 */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 107 */
        return viewModels.count /* 280 */
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { /* 112 */
        return 150 /* 113 */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 114 */
        tableView.deselectRow(at: indexPath, animated: true) /* 115 */
        let article = articles[indexPath.row] /* 275 */
        
        guard let url = URL(string: article.url ?? "") else { /* 276 */
            return /* 277 */
        }
        
        let vc = SFSafariViewController(url: url) /* 278 */
        present(vc, animated: true) /* 279 */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 108 */
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsTableViewCell.identifier,
            for: indexPath
        ) as? NewsTableViewCell else { /* 109 */ /* 271 change cell */
         fatalError() /* 272 */
        }
        cell.configure(with: viewModels[indexPath.row]) /* 273 */
        
        //show No Results
        return cell /* 111 */
    }
}

//MARK: - SearchVC
extension SearchNewsViewController: UISearchBarDelegate { /* 116 */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { /* 255 */
        guard let text = searchBar.text, !text.isEmpty else { /* 256 */
            return /* 257 */
        }
        
        NewsAPICaller.shared.search(with: text) { [weak self] result in /* 258 */
            switch result { /* 259 */
            case .success(let articles): /* 260 */
                self?.articles = articles /* 261 */
                self?.viewModels = articles.compactMap({ /* 262 */
                    NewsTableViewCellViewModel( /* 263 */
                        title: $0.title,
                        subtitle: $0.description ?? "No Description",
                        imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                
                DispatchQueue.main.async { /* 264 */
                    self?.resultsTable.reloadData() /* 265 */
                    self?.searchVC.dismiss(animated: true, completion: nil) /* 266 */
                }
                
            case .failure(let error): /* 260 */
                
                print(error) /* 267 */
            }
        }
    }
}
