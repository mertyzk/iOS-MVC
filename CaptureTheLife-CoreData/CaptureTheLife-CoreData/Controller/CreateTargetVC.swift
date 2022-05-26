//
//  CreateTargetVC.swift
//  CaptureTheLife-CoreData
//
//  Created by Macbook Air on 26.05.2022.
//

import UIKit

class CreateTargetVC: UIViewController {

    
    @IBOutlet weak var createTargetButtonOutlet: UIButton!
    
    @IBOutlet weak var txtTargetNumber: UITextField!
    
    var targetDesc : String!
    var targetType : TypesOfTarget!
    
    func dataAssigment(targetDesc: String, targetType: TypesOfTarget) {
        self.targetDesc = targetDesc
        self.targetType = targetType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        createTargetButtonOutlet.moveKeyboard()
        

    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func createTargetButtonClicked(_ sender: UIButton) {
        
        if txtTargetNumber.text != "" {
            if Int(txtTargetNumber.text!)! > 0 {
                self.save { finished in
                    if finished {
                        dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
    
    
    func save(completionHandler: (_ finished: Bool) -> ()){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let target = Target(context: managedContext)
        
        target.targetDesc = targetDesc
        target.targetType = targetType.rawValue
        target.targetValidNumber = Int32(txtTargetNumber.text!)!
        target.numberOfCompletedTarget = Int32(0)
        
        do {
            try managedContext.save()
            print("Data saved succesfully")
            completionHandler(true)
        } catch {
            debugPrint("Data registration failed: \(error.localizedDescription)")
            completionHandler(false)
        }
        
    }
    
    
}
