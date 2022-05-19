//
//  FilmCell.swift
//  FilmMuseum-MVC
//
//  Created by Macbook Air on 19.05.2022.
//

import UIKit

class FilmCell: UICollectionViewCell {
    
    @IBOutlet weak var imgFilm: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellEdit(film : Film){
        imgFilm.image = UIImage(named: film.imageName)
    }
}
