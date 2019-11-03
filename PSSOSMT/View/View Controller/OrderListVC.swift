//
//  OrderListVC.swift
//  PSSOSMT
//
//  Created by Bassuni on 10/31/19.
//  Copyright © 2019 futureface. All rights reserved.
//

import UIKit
import SVProgressHUD
class OrderListVC: UIViewController {

    @IBOutlet weak var ordersTBL: UITableView!
   
    var vm : OrdersListVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = OrdersListVM(_serviceAdapter: NetworkAdapter<TeaBoyEnum>())
        vm.delegate = self
//        ordersTBL.delegate = self
//        ordersTBL.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNotificationsCenter()
    }
    func addNotificationsCenter()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(notificationFire(_:)), name: NSNotification.Name("DeleteRow"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationFireRecevieNotification(_:)), name: NSNotification.Name("RecevieNotification"), object: nil)
    }


    @objc func notificationFireRecevieNotification(_ notification : Notification)
        {
            if(vm != nil && vm.delegate != nil)
            {
                vm.getOrders()
            }

        }


    @objc func notificationFire(_ notification : Notification)
    {
        guard  notification.userInfo != nil
            else {return}
        let userInfo = notification.userInfo as! Dictionary<String,Any>
        if let index = userInfo["IndexPath"] as? IndexPath
        {
            self.vm.orders.remove(at: index.row)
            self.ordersTBL.deleteRows(at: [index], with: .automatic)
        }
        
    }
}
extension OrderListVC : UITableViewDelegate , UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return vm.numberOfRowsInSection()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTVC
        let orderItem = vm.ordersAtIndex(indexPath.row)
        cell.configCell(item: orderItem, _index: indexPath)

        return cell;
    }
}
extension OrderListVC : BaseViewModelProtocol
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
        ordersTBL.delegate = self
        ordersTBL.dataSource = self
        ordersTBL.reloadData()
        }

        func showAlert(message: String) {
            hideLoading()
            alert(title: "alert",message: message, complete: {})
        }


    }
