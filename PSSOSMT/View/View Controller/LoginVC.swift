//
//  LoginVC.swift
//  PSSOSMT
//
//  Created by Bassuni on 10/31/19.
//  Copyright © 2019 futureface. All rights reserved.
//

import UIKit
import SVProgressHUD
class LoginVC: UIViewController {

    var vm : LoginVM!
    @IBOutlet weak var loginBtnProp: CustomeButton!
      @IBOutlet weak var userNameTxt: BindingTextField!{
        didSet {
            userNameTxt.bind(callBack: { self.vm.userCode = $0})
        }
       }

    
    override func viewDidAppear(_ animated: Bool) {
        userNameTxt.underlined()
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "ادخل الكود الخاص بك",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        vm = LoginVM(_serviceAdapter: NetworkAdapter<TeaBoyEnum>())
        vm.delegate = self
    }
    @IBAction func loginAction(_ sender: Any) {

        if(vm.isValid)
               {
                vm.login()
               }
               else{
                   alert(title: "Validation", message: vm.validationMessage, complete: {})
               }



    }
}

extension LoginVC : BaseViewModelProtocol
{
    func showLoading() {
         DispatchQueueHelper.delay(bySeconds: 0, dispatchLevel: .main) {
         SVProgressHUD.show(withStatus: "")
        }
    }

    func hideLoading() {
         DispatchQueueHelper.delay(bySeconds: 0, dispatchLevel: .main) {
        SVProgressHUD.dismiss()
        }
    }

    func callback() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
              let loginVC = storyBoard.instantiateViewController(withIdentifier: "orderListScreen") as! OrderListVC
              self.present(loginVC, animated: true, completion: nil);
    }

    func showAlert(message: String) {
        hideLoading()
        alert(title: "alert",message: message, complete: {})
    }


}
