//
//  CategoriesVC.swift
//  FilmMuseum-MVC
//
//  Created by Macbook Air on 19.05.2022.
//

import UIKit

class CategoriesVC: UIViewController {
    
    
    var datas = DataSet()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        
        if let filmlistVC = segue.destination as? FilmListVC{
            filmlistVC.category = datas.categories[index!]
        }
    }
}


extension CategoriesVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as? CategoryCell{
            cell.cellEdit(filmCat: datas.categories[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 // cell yuksekligi 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToFilmList", sender: indexPath.row)
    }
    
    
}
