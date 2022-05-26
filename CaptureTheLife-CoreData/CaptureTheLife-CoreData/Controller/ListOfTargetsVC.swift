//
//  ListOfTargetsVC.swift
//  CaptureTheLife-CoreData
//
//  Created by Macbook Air on 25.05.2022.
//

import UIKit
import CoreData


let appDelegate = UIApplication.shared.delegate as? AppDelegate


class ListOfTargetsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var arrayOfTargets : [Target] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.uploadData()
       
    }
    
    func uploadData(){
        self.getByAll { complete in
            if complete {
                if arrayOfTargets.count >= 1 {
                    // gosterilecek veri varsa
                    tableView.isHidden = false
                } else {
                    // gosterilecek veri yoksa
                    tableView.isHidden = true
                }
            }
        }
        tableView.reloadData()
    }


    @IBAction func addButtonClicked(_ sender: UIButton) {
       
        guard let addTargetVC = storyboard?.instantiateViewController(withIdentifier: "addTargetVC") else {
            return
        }
        newPresent(addTargetVC)
        
    }
    
}

extension ListOfTargetsVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTargets.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "targetCell") as? TargetCell else {
            return UITableViewCell()
        }
        
        let incomingData = arrayOfTargets[indexPath.row]
        cell.setView(target: incomingData)
	        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
                   (UIContextualAction, view, boolValue) in
            self.deleteData(indexPath: indexPath)
            self.uploadData()
        }
        
        /*let editAction = UIContextualAction(style: .normal, title: "Edit"){
                   (UIContextualAction, view, boolValue) in
            //code here
               }
        return UISwipeActionsConfiguration(actions: [deleteAction,editAction])*/
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    

    
    
    
    
}

extension ListOfTargetsVC {
    
    func deleteData(indexPath : IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(arrayOfTargets[indexPath.row])
        do {
            try managedContext.save()
            self.arrayOfTargets.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            print("Data delete successfully")
        } catch  {
            debugPrint("Error of data delete \(error.localizedDescription)")
        }
    }
    
    func getByAll(completionHandler : (_ complete: Bool) -> ()){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Target>(entityName: "Target")
        
        do {
            arrayOfTargets = try managedContext.fetch(fetchRequest)
            print("Incoming data successfully ")
            completionHandler(true)
        } catch {
            debugPrint("Data registration failed: \(error.localizedDescription)")
            completionHandler(false)
        }
        
    }
    
}
