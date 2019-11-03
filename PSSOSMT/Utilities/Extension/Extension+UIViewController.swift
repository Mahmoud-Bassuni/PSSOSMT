//
//  Extension+UIViewController.swift
//  PSSOSMT
//
//  Created by Bassuni on 11/1/19.
//  Copyright © 2019 futureface. All rights reserved.
//
import Foundation
import UIKit
extension UIViewController {
func alert(title : String, message : String , complete :@escaping ()->())
  {
      let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
          complete()
      }))
      self.present(alert, animated: true, completion: nil)
  }
}
