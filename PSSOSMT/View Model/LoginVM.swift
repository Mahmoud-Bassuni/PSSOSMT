//
//  LoginVM.swift
//  PSSOSMT
//
//  Created by Bassuni on 11/1/19.
//  Copyright © 2019 futureface. All rights reserved.
//

import Foundation
class LoginVM : BaseViewModel
{
    var brokenRules: [String] = []
       var validationMessage = ""
       var isValid: Bool
       {
           get {
           self.brokenRules = [String]()
               self.validate()
               return self.brokenRules.count == 0 ? true : false
           }
       }
    var userCode : String!
    var delegate : BaseViewModelProtocol?
    private var serviceAdapter : NetworkAdapter<TeaBoyEnum>!
    init(_serviceAdapter : NetworkAdapter<TeaBoyEnum>) {
        serviceAdapter = _serviceAdapter
    }
    func login() {
 DispatchQueueHelper.delay(bySeconds: 0) {
    self.delegate?.showLoading()
        }
        serviceAdapter.request(target: .login(userCode: userCode), success: { [unowned self] response in
                  do{
                      let decoder = JSONDecoder()
                      // decode the json object
                     let getData = try decoder.decode(LoginCodableModel.self,from: response.data)
                      DispatchQueueHelper.delay(bySeconds: 0) {

                        guard getData.errors?.count == 0 else {
                            self.delegate?.showAlert(message: (getData.errors?.first)!)
                            return }
                            self.setUserDefulats(getData.value!)

                          DispatchQueueHelper.delay(bySeconds: 0, dispatchLevel: .main) {
                              // realod data to table view after data fetch
                              self.delegate?.callback()
                          }
                      }
                  }
                  catch let err { print("Err", err)}
            }, error: {error  in self.delegate?.showAlert(message: error.localizedDescription)}
            , failure: {moyaError in self.delegate?.showAlert(message: moyaError.localizedDescription)})
    }

    func setUserDefulats(_ data : teaBoyInfoCodableModel){
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(data.id, forKey: "UserId");
        defaults.set(data.nameAr, forKey: "NameAr");
        defaults.set(data.nameEn, forKey: "NameEn");
        defaults.set(userCode, forKey: "UserCode");

    }
}
extension LoginVM
{
    func validate()
    {
        if(userCode == nil || userCode.isEmpty)
        {
            self.brokenRules.append("من فضلك ادخل الكود")

        }
        if(brokenRules.count > 0)
        {
            validationMessage =  brokenRules.joined(separator:"\n")
        }


    }
}
