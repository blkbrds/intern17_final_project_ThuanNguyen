//
//  HomeViewController.swift
//  FinalProject
//
//  Created by An Nguyen Q. VN.Danang on 08/06/2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        HUD.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            HUD.dismiss()
        }
        // Do any additional setup after loading the view.
    }

}
