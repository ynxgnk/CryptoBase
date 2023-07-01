//
//  CryptoAPICaller.swift
//  CryptoShield
//
//  Created by Nazar Kopeika on 04.06.2023.
//

/*

import Foundation

final class CryptoAPICaller {
    static let shared = CryptoAPICaller() /* 385 */
    
    private struct CryptoConstants { /* 386 */
//        static let cryptoAPIKey = "2365EB53-C1D2-4765-A671-1111698437C0" /* 388 */
        static let cryptoAPIKey = "" /* not to overload the api */
        static let assetsEndpoint = "https://rest.coinapi.io/v1/assets/" /* 389 */
        //        static let searchCryptoUrl = "https://rest.coinapi.io/v1/assets/?apikey=2365EB53-C1D2-4765-A671-1111698437C0"
    }
    
    private init() {} /* 387 */
    
    public var icons: [Icon] = [] /* 394 */
    
    private var whenReadyBlock: ((Result<[Crypto], Error>) -> Void)? /* 395 */
    
    //MARK: Public
    
    public func getAllCryptoData(
        completion: @escaping (Result<[Crypto], Error>) -> Void
    ) { /* 396 */
        guard !icons.isEmpty else { /* 397 */
            whenReadyBlock = completion /* 398 */
            return /* 399 */
        }
        
        guard let url = URL(string: CryptoConstants.assetsEndpoint + "?apikey=" + CryptoConstants.cryptoAPIKey) else { /* 400 */
            return /* 401 */
        }
        
        let task = URLSession.shared.dataTask(with: url) { data , response, error in /* 402 */
            guard let data = data, error == nil else { /* 403 */
                return /* 404 */
            }
            
            do { /* 405 */
                let result = try JSONDecoder().decode([Crypto].self, from: data) /* 406 */
                completion(.success(result.sorted { first, second -> Bool in /* 407 */
                    return first.price_usd ?? 0 > second.price_usd ?? 0 /* 408 */
                }))
                
            }
            catch { /* 409 */
                completion(.failure(error)) /* 410 */
            }
        }
        task.resume() /* 411 */
    }
    
    public func getAllIcons() { /* 412 */
        guard let url = URL(string: "https://rest.coinapi.io/v1/assets/icons/32/?apikey=2365EB53-C1D2-4765-A671-1111698437C0") else { /* 413 */
            return /* 414 */
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data , _, error in /* 415 */
            guard let data = data, error == nil else { /* 146 */
                return /* 417 */
            }
            
            do { /* 418 */
                self?.icons = try JSONDecoder().decode([Icon].self, from: data) /* 419 */
                if let completion = self?.whenReadyBlock { /* 420 */
                    self?.getAllCryptoData(completion: completion) /* 421 */
                }
            }
            
            catch { /* 422 */
                print(error) /* 423 */
            }
        }
        
        task.resume() /* 424 */
    }
 
 
    
//        public func searchCrypto(with query: String, completion: @escaping (Result<[Crypto], Error>) -> Void) { /* 503 */
//            guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { /* 504 */
//                return /* 505 */
//            }
//
//            let urlString = CryptoConstants.assetsEndpoint + query.lowercased() + "/?apikey=" + CryptoConstants.cryptoAPIKey /* 506 */
//            guard let url = URL(string: urlString) else { /* 507 */
//                return /* 508 */
//            }
//
//            let task = URLSession.shared.dataTask(with: url) { data , _, error in /* 509 */
//                if let error = error { /* 510 */
//                    completion(.failure(error)) /* 511 */
//                }
//                else if let data = data { /* 512 */
//                    do { /* 513 */
//                        let result = try JSONDecoder().decode(CryptoAPIResponse.self, from: data) /* 514 */
//    //                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//
//    //                    print(result)
//                        print("Icons: \(result.icons.count)") /* 515 */
//                        completion(.success(result.icons)) /* 516 */
//                    }
//                    catch { /* 517 */
//                        completion(.failure(error)) /* 518 */
//                    }
//                }
//            }
//
//            task.resume() /* 519 */
//        }
    
}

*/
