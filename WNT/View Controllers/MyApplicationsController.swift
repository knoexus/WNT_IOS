//
//  MyApplicationsController.swift
//  WNT
//
//  Created by AD on 16.03.2020.
//  Copyright © 2020 AD. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

var applications = [String]()
let cellIdentifier: String = "maCell"

class MyApplicationsController: UITableViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        queryApplications()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        applications = []
    }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return applications.count
    }
    
    func queryApplications(){
        guard let user = Auth.auth().currentUser?.uid else { return; }
           let db = Firestore.firestore()
           db.collection("applications").whereField("userId", isEqualTo: user)
               .getDocuments { (snapshot, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    else {
                        for document in snapshot!.documents {
                            let dt = document.data()
                            let type = dt["type"] ?? "not set"
                            let volume = dt["volume"] ?? "not set"
                            let language = dt["language"] ?? "not set"
                            applications.append("Type: \(String(describing: type)) - Vol: \(String(describing: volume)) - Lang: \(String(describing: language))")
                        }
                        self.tableView.reloadData()
                    }
                }

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MyApplicationCellTableViewCell else {
            fatalError("Could not cast the cell to the approptiate type")
        }
        
        cell.mainLabel.text = applications[indexPath.row]

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
