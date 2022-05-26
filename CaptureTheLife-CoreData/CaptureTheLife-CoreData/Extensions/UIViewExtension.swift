//
//  UIViewExtension.swift
//  CaptureTheLife-CoreData
//
//  Created by Macbook Air on 26.05.2022.
//

import Foundation
import UIKit

extension UIView {
    
    func moveKeyboard(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeKeyboard(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    @objc func changeKeyboard(_ nofitifaction : NSNotification){
        
        // klavye ne kadar surede yerini degistiriyor?
        
        let time = nofitifaction.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double // duration = time of keyboard moving
        
        let curve = nofitifaction.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        
        let keyboardStartingFrame = (nofitifaction.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardFinishedFrame = (nofitifaction.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let diffrenceOfY = keyboardFinishedFrame.origin.y - keyboardStartingFrame.origin.y
        
        UIView.animateKeyframes(withDuration: time, delay: 0.0, options: KeyframeAnimationOptions.init(rawValue: curve), animations: {
            self.frame.origin.y += diffrenceOfY
        }, completion: nil)
        
    }
    
}


// keyboardWillChangeFrameNotification => klavye boyutu degisimi kontrolu
