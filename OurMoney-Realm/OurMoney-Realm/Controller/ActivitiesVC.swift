//
//  ActivitiesVC.swift
//  OurMoney-Realm
//
//  Created by Macbook Air on 28.05.2022.
//

import UIKit
import RealmSwift

class ActivitiesVC: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var activities : Results<Activity>?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        getData()
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activities?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "activityCell")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
        cell.textLabel?.text = activities?[indexPath.row].Name ?? "Error Activity"
        
        if activities?[indexPath.row].IsItOver ?? false {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let selectedCell = tableView.cellForRow(at: indexPath)
        
        //tableView.cellForRow(at: indexPath)
        
        //activities[indexPath.row].IsItOver = !activities[indexPath.row].IsItOver
        
        /*if selectedCell?.accessoryType == UITableViewCell.AccessoryType.checkmark{
            selectedCell?.accessoryType = .none
        } else {
            selectedCell?.accessoryType = .checkmark
        }*/
        //tableView.reloadData() // cellforRowAt tekrar calisacak bir hucreyi sectigimizde. yukarida zaten secili olup olmadigini kontrol ettik.
        
        performSegue(withIdentifier: "toPaymentListVC", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPaymentListVC"{
            let goToVC = segue.destination as! PaymentListVC
            
            if let selectedIndex = tableView.indexPathForSelectedRow {
                goToVC.selectedActivity = activities?[selectedIndex.row]
            }
        }
    }
    
    
    
    @IBAction func buttonActivityAdd(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add a Activity", message: "Activity you want to add", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { txtActivityName in
            txtActivityName.placeholder = "Name of activity"
        }
        
        let addAction = UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { action in
            let txtActivityName = alertController.textFields![0]
            
            if !txtActivityName.text!.isEmpty{
                let a1 = Activity()
                a1.Name = txtActivityName.text!
                self.saveData(activity: a1)
                self.tableView.reloadData()
            }else{
                print("error")
            }

        }
        alertController.addAction(addAction)
        present(alertController,animated: true,completion: nil)
        
    }

    func saveData(activity: Activity){
        do {
            try realm.write{
                realm.add(activity)
            }
        } catch {
            print("Data save error : \(error.localizedDescription)")
        }
    }
    
    func getData(){
        
        activities = realm.objects(Activity.self)
        tableView.reloadData()
        
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contexualAction, view, boolValue in
            if let deletePayment = self.activities?[indexPath.row]{
                do {
                    try self.realm.write{
                        self.realm.delete(deletePayment.payments)
                        self.realm.delete(deletePayment)
                        tableView.reloadData()
                        print("Delete operation successfully")
                        tableView.reloadData()
                    }
                } catch {
                    print("Delete operation error : \(error.localizedDescription)")
                }
            }
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            getData() // No call?? Ok! Get All Data
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            // Making a call? OK! Filter data and run reload
            self.activities = self.activities?.filter("Name CONTAINS[cd] %@",searchBar.text!.lowercased()).sorted(byKeyPath: "Name", ascending: true)
            self.tableView.reloadData()
            
        }

    }
    
    
}

