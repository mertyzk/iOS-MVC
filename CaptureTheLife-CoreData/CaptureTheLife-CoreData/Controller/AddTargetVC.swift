//
//  AddTargetVC.swift
//  CaptureTheLife-CoreData
//
//  Created by Macbook Air on 26.05.2022.
//

import UIKit

class AddTargetVC: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var txtTargetDescription: UITextView!
    
    @IBOutlet weak var buttonLongTerm: UIButton!
    
    @IBOutlet weak var buttonMediumTerm: UIButton!
    
    @IBOutlet weak var buttonShortTerm: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var typeofTarget : TypesOfTarget = .LongTerm
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtTargetDescription.delegate = self
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        nextButton.moveKeyboard()
        buttonLongTerm.SelectedButtonBackgroundColor()
        buttonShortTerm.notSelectedButtonBackgroundColor()
        buttonMediumTerm.notSelectedButtonBackgroundColor()

        // Do any additional setup after loading the view.
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func buttonLongTerm(_ sender: UIButton) {
        typeofTarget = .LongTerm
        buttonLongTerm.SelectedButtonBackgroundColor()
        buttonShortTerm.notSelectedButtonBackgroundColor()
        buttonMediumTerm.notSelectedButtonBackgroundColor()
    }
    
    @IBAction func buttonMediumTerm(_ sender: UIButton) {
        
        typeofTarget = .MediumTerm
        buttonLongTerm.notSelectedButtonBackgroundColor()
        buttonShortTerm.notSelectedButtonBackgroundColor()
        buttonMediumTerm.SelectedButtonBackgroundColor()
    }
    
    
    @IBAction func buttonShortTerm(_ sender: UIButton) {
        
        typeofTarget = .ShortTerm
        buttonLongTerm.notSelectedButtonBackgroundColor()
        buttonShortTerm.SelectedButtonBackgroundColor()
        buttonMediumTerm.notSelectedButtonBackgroundColor()
    }
    
    @IBAction func buttonNextClicked(_ sender: UIButton) {
        
        if txtTargetDescription.text != "" && txtTargetDescription.text != "Write down the target you want to reach." {
            guard let createTargetVC = storyboard?.instantiateViewController(withIdentifier: "createTargetVC") as? CreateTargetVC else {
                return
            }
            
            createTargetVC.dataAssigment(targetDesc: txtTargetDescription.text, targetType: typeofTarget)
            presentingViewController?.newPresent2(createTargetVC)
            
        }
        
    }
    
    
    @IBAction func buttonBackClicked(_ sender: UIButton) {
        newDismiss()
    }
    
    /*func textViewDidBeginEditing(_ textView: UITextView) {
        txtTargetDescription.text = ""
        txtTargetDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }*/
    
    
}
