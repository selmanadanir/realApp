//
//  ViewController.swift
//  realApp
//
//  Created by Selman ADANİR on 25.07.2022.
//

import UIKit

class ViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var photos = [Photos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLogo()
        getPhotos()
        
    }
    
    func loadLogo(){
        if let logo = UIImage(named: "the-new-york-times-logo.png"){
            let newLogo = Util.app.resizeImage(image: logo, targetSize: CGSize(width: 200, height: 50))
            let imageView = UIImageView(image: newLogo)
            self.navigationItem.titleView = imageView
            
        }
    }
    
    func getPhotos(){
        
        photos = []
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        let task = URLSession.shared.dataTask(with: url)  { (data, response, error) in
            
            if let error = error {
                print("Error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse{
                    print("Status Code: \(response.statusCode)")
                }
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]] {
                        //print(json)
                        for dic in json{
                            self.photos.append(Photos(dic))
                        }
                        
                        self.photos = Array(self.photos.prefix(10))
                        
                        DispatchQueue.main.sync {
                            self.tableView.reloadData()
                        }
                    }
                    
                }
                catch let error as NSError{
                    print("Error: \(error.localizedDescription)")
                }
                
            }
            
        }
        task.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        let row = photos[indexPath.row]
        cell.titleLabel.text = row.title
        cell.myImage.load(url: URL(string: row.url)!)
        return cell
    }
    
    
    
}


extension UIImageView{
    func load(url: URL){
        DispatchQueue.global().sync { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
