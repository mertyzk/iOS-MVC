//
//  CategoryCell.swift
//  FilmMuseum-MVC
//
//  Created by Macbook Air on 19.05.2022.
//

import UIKit

class CategoryCell: UITableViewCell {

    
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblCategoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // her hucre olusturuldugunda
        imgCategory.layer.cornerRadius = 10 // goruntu koselerindeki radiusu arttirdik (yuvarlaklasmayi artirdik oval goruntu icin)
    }
    
    func cellEdit(filmCat : FilmCategory) {
        imgCategory.image = UIImage(named: filmCat.imageName)
        lblCategoryName.text = filmCat.categoryName
    }


}
