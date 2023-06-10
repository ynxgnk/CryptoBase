//
//  SearchCryptoViewController.swift
//  CryptoShield
//
//  Created by Nazar Kopeika on 04.06.2023.
//

import Foundation
import UIKit /* 482 */

protocol SearchCryptoViewControllerDelegate: AnyObject {
    func didSelectCrypto(_ crypto: Crypto)
}


final class SearchCryptoViewController: UIViewController { /* 483 */
    
    weak var delegate: SearchCryptoViewControllerDelegate?

    
    private let cryptoTable: UITableView = { /* 476 */
        let table = UITableView() /* 477 */
        table.register(HomeTableViewCell.self,
                       forCellReuseIdentifier: HomeTableViewCell.identifier) /* 478 */
        return table /* 479 */
    }()
    
    private let searchVC = UISearchController(searchResultsController: nil) /* 498 */
    
    private var cryptoViewModels = [CryptoTableViewCellViewModel]() /* 531 */
//    private var icons = [Crypto]() /* 537 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cryptoTable) /* 484 */
        view.backgroundColor = .systemBackground /* 496 */
        cryptoTable.delegate = self /* 486 */
        cryptoTable.dataSource = self /* 487 */
        
        createSearchBar() /* 522 */
        navigationItem.hidesSearchBarWhenScrolling = false /* 538 */
//        cryptoTable.backgroundColor = .red
    }
    
    override func viewDidLayoutSubviews() { /* 480 */
        super.viewDidLayoutSubviews() /* 481 */
        cryptoTable.frame = view.bounds /* 485 */
    }
    
    private func createSearchBar() { /* 497 */
        navigationItem.searchController = searchVC /* 499 */
//        searchVC.searchBar.delegate = self /* 500 */
        searchVC.searchBar.placeholder = "Search for crypto..." /* 501 */
        searchVC.searchBar.searchBarStyle = .minimal /* 502 */
        
    }
}

//MARK: Table

extension SearchCryptoViewController: UITableViewDelegate, UITableViewDataSource { /* 488 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 489 */
        return cryptoViewModels.count /* 534 */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 490 */
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { /* 491 */
            fatalError() /* 492 */
        }
        cell.cryptoConfigure(with: cryptoViewModels[indexPath.row]) /* 530 */
        return cell /* 493 */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 494 */
        tableView.deselectRow(at: indexPath, animated: true) /* 495 */
//        let icon = icons[indexPath.row] /* 539 */
//        let cryptoDetails = CryptoDetailsViewController() /* 532 */
//        navigationController?.pushViewController(cryptoDetails, animated: true) /* 533 */
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { /* 535 */
        140 /* 536 */
    }
    
    
}

//MARK: SearchDelegate
//extension SearchCryptoViewController: UISearchBarDelegate { /* 540 */
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { /* 540 */
//        guard let text = searchBar.text, !text.isEmpty else { /* 540 */
//            return /* 540 */
//        }
//
//        CryptoAPICaller.shared.searchCrypto(with: text) { [weak self] result in /* 540 */
//            switch result { /* 541 */
//            case .success(let icons): /* 542 */
//                self?.icons = icons /* 546 */
//                self?.cryptoViewModels = icons.compactMap({ model in /* 547 */
//                    let price = model.price_usd ?? 0
//                    let formatter = Formatters.cryptoNumberFormatter
//                    let priceString = formatter.string(from: NSNumber(value: price))
//                    let iconUrl = URL(string:
//                                        CryptoAPICaller.shared.icons.filter({ icon in /* 554 */
//                        icon.asset_id == model.asset_id /* 555 */
//                    }).first?.url ?? "" /* 556 */
//                    )
//
//                    if price < 100000 { /* 557 */
//                        return CryptoTableViewCellViewModel(
//                            name: model.name ?? "N/A",
//                            symbol: model.asset_id,
//                            price: priceString ?? "N/A",
//                            iconUrl: iconUrl
//                        ) /* 558 */
//                    } else { /* 559 */
//                        return nil /* 560 */
//                    }
//                })
//
//                DispatchQueue.main.async { /* 549 */
//                    self?.cryptoTable.reloadData() /* 550 */
//                    self?.searchVC.dismiss(animated: true, completion: nil) /* 551 */
//                }
//
//            case .failure(let error): /* 552 */
//
//                print(error) /* 553 */
//            }
//        }
//    }
//
//}
