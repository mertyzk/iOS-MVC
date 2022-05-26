//
//  UIViewControllerExtension.swift
//  CaptureTheLife-CoreData
//
//  Created by Macbook Air on 26.05.2022.
//

import Foundation
import UIKit

extension UIViewController{
    
    func newPresent(_ viewControllertoPresent : UIViewController) {
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = .push
        transition.subtype = .fromRight
        self.view.window?.layer.add(transition, forKey: "presentAnimation")
        viewControllertoPresent.modalPresentationStyle = .fullScreen
        present(viewControllertoPresent, animated: false, completion: nil)
    }
    
    func newDismiss(){
        let viewControllertoPresent = UIViewController()
        viewControllertoPresent.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = .push
        transition.subtype = .fromLeft
        self.view.window?.layer.add(transition, forKey: "dismissAnimation")
        dismiss(animated: false, completion: nil)
    }
    
    
    func newPresent2(_ viewControllertoPresent : UIViewController) {

        let transition = CATransition()
        transition.duration = 0.6
        transition.type = .push
        transition.subtype = .fromRight
        
        guard let sunulanVC = presentedViewController else { return }
        sunulanVC.dismiss(animated: false) {
        self.view.window?.layer.add(transition, forKey: "presentAnimation2")
        viewControllertoPresent.modalPresentationStyle = .fullScreen
        self.present(viewControllertoPresent, animated: false, completion: nil)
        }
    }
    
    
}
