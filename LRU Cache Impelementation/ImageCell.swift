//
//  ImageCell.swift
//  LRU Cache Impelementation
//
//  Created by YUSUF KESKİN on 30.10.2022.
//

import Foundation
import UIKit

class ImageCell : UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        img.image = nil
    }
    
}
