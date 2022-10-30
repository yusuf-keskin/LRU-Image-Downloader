//
//  ImageViewModel.swift
//  LRU Cache Impelementation
//
//  Created by YUSUF KESKİN on 30.10.2022.
//

import Foundation
import Combine

class ImageViewModel {
    
    var observers = [AnyCancellable]()
    
    func getData(completion : @escaping (_ images : [ImageModel]) -> Void ) {
        ImageApı.shared.downloadImage()
            .decode(type: [ImageModel].self, decoder: JSONDecoder())
            .sink { result in
            switch result {
            case .failure(let error) :
                print(error)
            case .finished :
                print("yahhhooooo")
            }
        } receiveValue: { images in
            completion(images)
        }.store(in: &observers)
    }
}
