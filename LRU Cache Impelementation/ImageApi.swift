//
//  ImageApi.swift
//  LRU Cache Impelementation
//
//  Created by YUSUF KESKİN on 30.10.2022.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidUrl
    case unknown(error: Error?)
    case decoding(error: Error?)
    case request(statusCode: Int, error: Error?)
}

class ImageApı {
 
    static let shared = ImageApı()
}

extension ImageApı {
    func downloadImage() -> Future<Data, Error>  {
        return Future { promise in
            guard let url = URL(string: IMAGES_URL) else { return }
            let session = URLSession.shared
            session.dataTask(with: url) { data, response, error in
                
                guard let data = data else {
                    print("No data acquired")
                    promise(.failure(APIError.unknown(error: error)))
                    return
                }
                promise(.success(data))
            }.resume()
        }
    }
}






