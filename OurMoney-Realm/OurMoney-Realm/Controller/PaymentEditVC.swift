//
//  PaymentEditVC.swift
//  OurMoney-Realm
//
//  Created by Macbook Air on 28.05.2022.
//

import UIKit
import RealmSwift

class PaymentEditVC: UIViewController {
    
    let realm = try! Realm()
    
    var selectedPayment : Payment?

    @IBOutlet weak var txtPayPersonName: UITextField!
    
    @IBOutlet weak var txtDesc: UITextField!
    
    @IBOutlet weak var txtCash: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setByView()
    }
    
    
    @IBAction func updatePayClickedButton(_ sender: Any) {
        
        
        if let selectedPayment = selectedPayment {
            do {
                try realm.write{
                    selectedPayment.payerName = txtPayPersonName.text!
                    selectedPayment.desc = txtDesc.text!
                    selectedPayment.quantity = Int((txtCash.text)!)!
                    print("Payment update successfully")
                }
            } catch {
                print("Payment update error : \(error.localizedDescription)")
            }
        }
        
        navigationController?.popViewController(animated: true)
        
        
        
    }
    
    func setByView(){
        txtPayPersonName.text = selectedPayment?.payerName
        txtDesc.text = selectedPayment?.desc
        txtCash.text = "\(selectedPayment!.quantity)"
        
    }
    

}
