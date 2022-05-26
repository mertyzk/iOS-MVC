//
//  UIButtonExtension.swift
//  CaptureTheLife-CoreData
//
//  Created by Macbook Air on 26.05.2022.
//

import Foundation
import UIKit

extension UIButton {
    
    func notSelectedButtonBackgroundColor(){
        self.backgroundColor = #colorLiteral(red: 0.9736215472, green: 0.9078238606, blue: 0.3090230525, alpha: 1)
    }
    
    func SelectedButtonBackgroundColor(){
        self.backgroundColor = #colorLiteral(red: 1, green: 0.5856812596, blue: 0, alpha: 1)
    }
    
}
