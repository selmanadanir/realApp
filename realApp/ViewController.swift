//
//  ViewController.swift
//  realApp
//
//  Created by Selman ADANİR on 25.07.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLogo()
        
    }
    
    func loadLogo(){
        if let logo = UIImage(named: "the-new-york-times-logo.png"){
            let newLogo = Util.app.resizeImage(image: logo, targetSize: CGSize(width: 200, height: 50))
            let imageView = UIImageView(image: newLogo)
            self.navigationItem.titleView = imageView
            
        }
    }
}
