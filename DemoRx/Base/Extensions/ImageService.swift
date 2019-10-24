//
//  ImageService.swift
//  SampleRxSwift
//
//  Created by Adrian Cervantes on 5/3/19.
//  Copyright © 2019 Yan Cervantes. All rights reserved.
//

import UIKit

class ImageService {
    lazy var imageCache = NSCache<AnyObject, AnyObject>()
    
    func downloadImage(withBucketURL url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        var imageUrl: String?
        imageUrl = url
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            completion(.success(imageFromCache))
            return
        } else {
            guard let urlSession = URL(string: url) else { return }
            URLSession.shared.dataTask(with: urlSession) { [weak imageCache] (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    guard let data = UIImage(data: data) else { return }
                    let imageCompressed = data.jpegData(compressionQuality: 0.01)
                    let image = UIImage(data: imageCompressed ?? Data())
                    DispatchQueue.main.async {
                        if imageUrl == url {
                            guard let image = image else { return }
                            completion(.success(image))
                        }
                        imageCache?.setObject(image ?? UIImage(), forKey: url as AnyObject)
                    }
                } else {
                    print("placeHolder image")
                    imageUrl = nil
                }
            }.resume()
        }
    }
}

extension UIImage {
    
}
