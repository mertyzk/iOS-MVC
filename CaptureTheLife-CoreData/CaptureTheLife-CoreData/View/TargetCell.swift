//
//  TargetCell.swift
//  CaptureTheLife-CoreData
//
//  Created by Macbook Air on 25.05.2022.
//

import UIKit

class TargetCell: UITableViewCell {

    
    @IBOutlet weak var lblTarget: UILabel!
    
    @IBOutlet weak var lblTargetDesc: UILabel!
    
    @IBOutlet weak var lblTargetNumber: UILabel!
    
    func setView(target: Target) {
        lblTarget.text = target.targetDesc
        lblTargetDesc.text = target.targetType
        lblTargetNumber.text = String(target.targetValidNumber)
    }
    
    
    
    /*override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/

}
