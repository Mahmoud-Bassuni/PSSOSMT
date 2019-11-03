//
//  OrderTVC.swift
//  PSSOSMT
//
//  Created by Bassuni on 10/31/19.
//  Copyright © 2019 futureface. All rights reserved.
//

import UIKit
import SVProgressHUD
class OrderTVC: UITableViewCell {

       @IBOutlet var orderNameTxtProp: UILabel!
       @IBOutlet var orderBtnProp: CustomeButtonWithLightRadius!
       @IBOutlet var orderImageProp: CustomImageView!
       @IBOutlet var empNameTxtProp: UILabel!
       var vm : OrderVM!
      var indexPath : IndexPath!
    @IBAction func orderAction(_ sender: Any) {
        vm.delegate = self
        vm.updateOrderStatus()
    }

    func configCell(item : OrderVM , _index : IndexPath)  {
           vm = item
        indexPath = _index
           orderNameTxtProp.text = item.orderName
           empNameTxtProp.text = item.empNme
        orderBtnProp.setTitle(item.orderStatusId == 1 ? "ابدا الان" : "تم الانتهاء"  , for: .normal)
        orderBtnProp.backgroundColor = UIColor.init(named: item.orderStatusId == 1 ? "pending" : "Start")
           guard  item.orderImage != "" else {return}
           orderImageProp.loadImageUsingUrlString(urlString : item.orderImage)

       }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
extension OrderTVC : BaseViewModelProtocol
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
        hideLoading()
              DispatchQueueHelper.delay(bySeconds: 0, dispatchLevel: .main) {
                if(self.vm.orderStatusId == 1 && self.orderBtnProp.tag != 2)
                {
                    self.orderBtnProp.tag = 2
                    self.orderBtnProp.backgroundColor = UIColor.init(named: "Start")
                    self.orderBtnProp.setTitle("تم الانتهاء", for: .normal)
                }
                else {
                    let dict : [String : Any] =  ["IndexPath" :  self.indexPath]
                    NotificationCenter.default.post(name: Notification.Name("DeleteRow"), object : nil, userInfo: dict)


                }

            }
        }

        func showAlert(message: String) {
            hideLoading()

        }


    }
