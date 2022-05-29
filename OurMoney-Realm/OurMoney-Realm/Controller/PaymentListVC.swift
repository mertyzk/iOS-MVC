//
//  PaymentListVC.swift
//  OurMoney-Realm
//
//  Created by Macbook Air on 28.05.2022.
//

import UIKit
import RealmSwift

class PaymentListVC: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let realm = try! Realm()
    var paymentsList : Results<Payment>?
    var selectedActivity: Activity? {
        
        didSet {
            getByPayments()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return paymentsList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath)
        if let paymentsList = paymentsList?[indexPath.row] {
            cell.textLabel?.text = "\(paymentsList.payerName) \(paymentsList.quantity)"
        } else {
            cell.textLabel?.text = "Payment not found"
        }
        return cell
    }

    @IBAction func btnAddPaymentClicked(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Payment", message: "Add a payment", preferredStyle: .alert)
        
        alertController.addTextField { txtPersonName in
            txtPersonName.placeholder = "Payer"
        }
        
        alertController.addTextField { txtDesc in
            txtDesc.placeholder = "Description"
        }
        
        alertController.addTextField { txtPay in
            txtPay.placeholder = "Pay"
            txtPay.keyboardType = .numberPad
        }
        
        let add = UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { action in
            
            let txtPerson = alertController.textFields![0]
            let txtDesc = alertController.textFields![1]
            let txtPay = alertController.textFields![2]
            
            if let selectedActivity = self.selectedActivity {

                do {
                    try self.realm.write{
                        let newPayment = Payment()
                        newPayment.payerName = txtPerson.text ?? "Not"
                        newPayment.desc = txtDesc.text ?? "Not"
                        newPayment.quantity = Int(txtPay.text ?? "-1")!
                        selectedActivity.payments.append(newPayment)
                    }
                } catch {
                    print("Error : \(error.localizedDescription)")
                }
                
            }
            self.tableView.reloadData()
            
        }
        alertController.addAction(add)
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToPaymentEdit", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPaymentEdit" {
            let goToVC = segue.destination as! PaymentEditVC
            
            if let selectedIndex = tableView.indexPathForSelectedRow {
                if let selectedPayment = paymentsList?[selectedIndex.row] {
                    goToVC.selectedPayment = selectedPayment
                    goToVC.title = "\(selectedPayment.payerName) Payment Information"
                }
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contexualAction, view, boolValue in
            if let deletePayment = self.paymentsList?[indexPath.row]{
                do {
                    try self.realm.write{
                        self.realm.delete(deletePayment)
                        tableView.reloadData()
                        print("Delete operation successfully")
                    }
                } catch {
                    print("Delete operation error : \(error.localizedDescription)")
                }
            }
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    
    func getByPayments(){
        paymentsList = realm.objects(Payment.self)
        tableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            getByPayments() // No call?? Ok! Get All Data
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            // Making a call? OK! Filter data and run reload
            self.paymentsList = self.paymentsList?.filter("payerName CONTAINS[cd] %@",searchBar.text!)
            self.tableView.reloadData()
        }
    }

}
