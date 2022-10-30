//
//  UIImageView+Extension.swift
//  LRU Cache Impelementation
//
//  Created by YUSUF KESKİN on 30.10.2022.
//

import UIKit

let cache = CacheLRU<String, UIImage>(capacity: 40)

extension UIImageView {
    
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            return
        }

        DispatchQueue.global().async { [weak self] in
          
                    if let savedData = cache.getValue(for: imageURLString) {
                    print("Using LRU cache")
                       DispatchQueue.main.async {
                           self?.image = savedData
                       }
                    
                    } else {
                        do {
                            let data = try Data(contentsOf: URL(string: imageURLString)!)

                                if let image = UIImage(data: data) {
                                    print("Using web, downloading from link : \(imageURLString)")
                                    let processedImage = image.resizeImageTo(size: CGSize(width: 200.00, height: 250.00))
                                    DispatchQueue.main.async {
                                        self?.image = processedImage
                                    }
                                    cache.setValue(processedImage!, for: imageURLString)
                                } else {
                                    print("Failed to set Image from server")
                                }

                        } catch (let error) {
                            print(error)
                            DispatchQueue.main.async {
                                self?.image = UIImage(named: "default.png")
                            }
                            
                        }
                    }
        }
    }
}

extension UIImage {
    
    func resizeImageTo(size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
