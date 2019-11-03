//
//  ViewController.swift
//  PSSOSMT
//
//  Created by Bassuni on 10/31/19.
//  Copyright © 2019 futureface. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

  @IBOutlet weak var logoPicProp: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logoPicProp.alpha = 0.0
        self.logoPicProp.fadeIn(completion: {
            (finished: Bool) -> Void in
            let defaults:UserDefaults = UserDefaults.standard
            let userId = defaults.integer(forKey: "UserId")
             if (userId > 0) {
             let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             let loginVC = storyBoard.instantiateViewController(withIdentifier: "orderListScreen") as! OrderListVC
             self.present(loginVC, animated: true, completion: nil);
            }
            else
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginScreen") as! LoginVC
                self.present(loginVC, animated: true, completion: nil);
            }
        })
    }

}

