//
//  OrderListVM.swift
//  PSSOSMT
//
//  Created by Bassuni on 11/1/19.
//  Copyright © 2019 futureface. All rights reserved.
//
import Foundation
class OrdersListVM
{
    var delegate : BaseViewModelProtocol!
    var orders : [OrdersCodableValue] = []
    var serviceAdapter : NetworkAdapter<TeaBoyEnum>!
    init(_serviceAdapter : NetworkAdapter<TeaBoyEnum>) {
        self.serviceAdapter = _serviceAdapter
        getOrders()
    }
    deinit {
        orders = []
        delegate = nil
    }
    func getOrders()
    {
        DispatchQueueHelper.delay(bySeconds: 0, dispatchLevel: .main) {
            self.delegate?.showLoading()
        }
        serviceAdapter.request(target: .getTeaBoyOrders, success: { [unowned self] Response in
                  do
                  {
                      let decoder = JSONDecoder()
                      let getData = try decoder.decode(OrdersCodableModel.self,from: Response.data)
                      DispatchQueue.global(qos: .background).async {
                        guard getData.value.count > 0 else {
                               DispatchQueueHelper.delay(bySeconds: 0, dispatchLevel: .main) {
                                  self.delegate?.hideLoading()
                              }
                              return
                          }
                        self.orders = getData.value
                            DispatchQueueHelper.delay(bySeconds: 0, dispatchLevel: .main) {
                              self.delegate?.callback()
                          }
                      }
                  }
                  catch let err { print("Err", err)}
                  }, error: { Error in
                    self.delegate?.showAlert(message: Error.localizedDescription)
              }) { MoyaError in
                  self.delegate?.showAlert(message: MoyaError.localizedDescription)
              }
    }

}
extension OrdersListVM {
    var numberOfSections: Int {
        return 1
    }
    func numberOfRowsInSection() -> Int {
        return self.orders.count
    }
    func ordersAtIndex(_ index: Int) -> OrderVM {
        let order = orders[index]
        return OrderVM(order)
    }
}
struct OrderVM {
    var delegate : BaseViewModelProtocol!
    func updateOrderStatus()
    {
        DispatchQueueHelper.delay(bySeconds: 0) {
        self.delegate?.showLoading()
            }
        NetworkAdapter<TeaBoyEnum>().request(target: .updateTeaBoyOrderStatus(orderId : orderId , statusID : orderStatusId + 1), success: {  response in
                      do{
                          let decoder = JSONDecoder()
                          // decode the json object
                         let getData = try decoder.decode(UpdateOrderStatusCodableModel.self,from: response.data)
                          DispatchQueueHelper.delay(bySeconds: 0) {

                            guard getData.errors?.count == 0 || getData.value == true else {
                                self.delegate?.showAlert(message: (getData.errors?.first)!)
                                return }


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
    private let order: OrdersCodableValue
    init(_ _order: OrdersCodableValue) {
        self.order = _order
    }
}
extension OrderVM {
    var empNme: String {
        guard  self.order.employee != nil else { return ""}
        return self.order.employee.nameAr
    }
    var orderName: String {
        guard  self.order.orderItems.count > 0 else { return ""}
        return (self.order.orderItems.first?.nameAr)!
    }
    var orderId: Int {
        guard  self.order.id != nil  else { return 0}
        return (self.order.id)!
    }
    var orderImage: String {
         guard  self.order.orderItems.count > 0 else { return ""}
        return (self.order.orderItems.first?.imagePath)!
    }
    var orderStatus: String {
        guard  self.order.orderStatus != nil else { return ""}
        return self.order.orderStatus.nameAr
    }
    var orderStatusId: Int {
        guard  self.order.orderStatus != nil else { return 0}
        return self.order.orderStatus.id
    }
}


