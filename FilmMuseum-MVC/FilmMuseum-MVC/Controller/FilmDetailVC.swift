//
//  FilmDetailVC.swift
//  FilmMuseum-MVC
//
//  Created by Macbook Air on 19.05.2022.
//

import UIKit

class FilmDetailVC: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelFilmName: UILabel!
    
    @IBOutlet weak var textArea: UITextView!
    
    var selectedFilm : Film?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedFilm = selectedFilm{
            imageView.image = UIImage(named: selectedFilm.imageName)
            labelFilmName.text = selectedFilm.filmName
            textArea.text = selectedFilm.details
        }
    }
    


}
