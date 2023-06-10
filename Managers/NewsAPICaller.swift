//
//  NewsAPICaller.swift
//  CryptoShield
//
//  Created by Nazar Kopeika on 04.06.2023.
//

import Foundation

final class NewsAPICaller { /* 147 */
    static let shared = NewsAPICaller() /* 148 */
    
    struct Constants { /* 149 */
        static let NewsAPIKey = "7be67da124e64c6e957a0a1df0fb8f21" /* 150 */
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=US&apiKey=\(NewsAPIKey)") /* 151 */
        static let searchUrlString = "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=\(NewsAPIKey)&q=" /* 152 */
    }
    
    enum APIError { /* 154 */
        case noSuchAPI /* 155 */
        
    }
    
    private init() {} /* 153 */
    
    public func getTopStories(completion: @escaping (Result<[NewsTitlesModel], Error>) -> Void) { /* 156 */
        guard let url = Constants.topHeadlinesURL else { /* 157 */
            return /* 158 */
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in /* 159 */
            if let error = error { /* 160 */
                completion(.failure(error)) /* 161 */
            }
            else if let data = data { /* 168 */
                do { /* 169 */
                    let result = try JSONDecoder().decode(NewsAPIResponse.self, from: data) /* 170 */
                     
                    print("Articles: \(result.articles.count)") /* 171 */
                    completion(.success(result.articles)) /* 172 */
                }
                catch { /* 173 */
                    completion(.failure(error)) /* 174 */
                }
            }
        }
        task.resume() /* 175 */
    }
    
    public func search(with query: String, completion: @escaping (Result<[NewsTitlesModel], Error>) -> Void) { /* 236 */
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { /* 237 */
            return /* 238 */
        }
        
        let urlString = Constants.searchUrlString + query /* 239 */
        guard let url = URL(string: urlString) else { /* 240 */
            return /* 241 */
        }
        
        let task = URLSession.shared.dataTask(with: url) { data , _, error in /* 242 */
            if let error = error { /* 243 */
                completion(.failure(error)) /* 244 */
            }
            else if let data = data { /* 245 */
                do { /* 246 */
                    let result = try JSONDecoder().decode(NewsAPIResponse.self, from: data) /* 247 */
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    print(result)
                    print("Articles: \(result.articles.count)") /* 248 */
                    completion(.success(result.articles)) /* 249 */
                }
                catch { /* 250 */
                    completion(.failure(error)) /* 251 */
                }
            }
        }
        
        task.resume() /* 252 */
    }
}
