//
//  FilmListVC.swift
//  FilmMuseum-MVC
//
//  Created by Macbook Air on 19.05.2022.
//

import UIKit

class FilmListVC: UIViewController {
    
    var datas = DataSet()
    var selectedFilm : Film!
    var category : FilmCategory?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        if let category = category {
            print(category.categoryName)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let filmDetailVC = segue.destination as? FilmDetailVC{
            filmDetailVC.selectedFilm = selectedFilm
        }
    }
    
}

extension FilmListVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    // flow layout itemlar olusturulurken boyutları atamak icin. cell'e custom boyut atamak icin.
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.getFilmsByCategory(cat: category!.categoryName).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let filmCell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmDetailCell", for: indexPath) as? FilmCell{
            filmCell.cellEdit(film: datas.getFilmsByCategory(cat: category!.categoryName)[indexPath.row])
            return filmCell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width
        let cellSize = (width / 2) - 15
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFilm = datas.getFilmsByCategory(cat: category!.categoryName)[indexPath.row]
        self.performSegue(withIdentifier: "goToFilmDetail", sender: indexPath.row)
    }
    
    
}
