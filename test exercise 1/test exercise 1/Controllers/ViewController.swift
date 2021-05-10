//
//  ViewController.swift
//  test exercise 1
//
//  Created by Vladimir Gorbunov on 06.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: ViewController extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func downloadImage(withURL url: URL, forCell cell: UITableViewCell) {
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            if data != nil {
                DispatchQueue.main.async {
                    cell.backgroundView = UIImageView(image: UIImage(data: data!))
                    cell.backgroundView?.contentMode = .scaleAspectFill
                }
            }
        }
        task.resume()
    }
    
    //MARK: tableView delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myBestCell", for: indexPath)
        let url = URL(string: "http://placehold.it/375x150?text=\(indexPath.row + 1)")!
        
        downloadImage(withURL: url, forCell: cell)
        
        return cell
    }
    
    
}

