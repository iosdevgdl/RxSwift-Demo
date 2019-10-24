//
//  Api.swift
//  DemoRx
//
//  Created by Yan Cervantes on 9/30/19.
//  Copyright © 2019 Yan Cervantes. All rights reserved.
//

import Foundation

class Api {
    static var url: URL {
        let urlString = "http://localhost:1337/posts"
        if let url = URL(string: urlString) {
            return url
        } else {
            return URL(string: "")!
        }
    }
    
    static func getModel(completion: @escaping ( Result<[Journies]?, Error>) -> Void) {
        URLSession.shared.dataTask(with: Api.url) { (data, response, error) in
               if let error = error {
                   completion(.failure(error))
               }
               guard let data = data else { return }
               do {
                   let model = try JSONDecoder().decode([Journies].self, from: data)
                   completion(.success(model))
               } catch let error {
                   completion(.failure(error))
               }
           }.resume()
       }
}
