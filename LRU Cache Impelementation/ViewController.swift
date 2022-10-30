//
//  ViewController.swift
//  LRU Cache Impelementation
//
//  Created by YUSUF KESKİN on 30.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    let model : ImageViewModel = ImageViewModel()
    
    var data = [ImageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        
        model.getData { [self] images in
            data.append(contentsOf: images)
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ImageCell") as? ImageCell
        let data = data[indexPath.row]

        cell?.img.setCustomImage(data.downloadURL)
        return cell ?? UITableViewCell()
    }
    
    
}

