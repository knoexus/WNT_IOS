//
//  ApplicationFormController.swift
//  WNT
//
//  Created by AD on 16.03.2020.
//  Copyright © 2020 AD. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ApplicationFormController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: { () in
                self.navigationController?.popViewController(animated: true)
            })
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var langField: UITextField!
    
    @IBOutlet weak var volumeField: UITextField!
    
    @IBOutlet weak var typeField: UITextField!
    
    @IBOutlet weak var duedateField: UITextField!
    
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var sampleText: UITextView!
    
    @IBAction func enterTapped(_ sender: Any) {
        let db = Firestore.firestore()
        guard let user = Auth.auth().currentUser?.uid else { return }
        db.collection("applications").addDocument(data: [
            "language": langField.text ?? "",
            "volume": volumeField.text ?? "",
            "type": typeField.text ?? "",
            "dueDate": duedateField.text ?? "",
            "phone": phoneField.text ?? "",
            "sample": sampleText.text ?? "",
            "userId": user,
            "date": Date()
        ]) { (error) in
            if let error = error {
                self.createAlert(title: "Error", message: error.localizedDescription)
            }
            else {
                self.createAlert(title: "Success", message: "You application has been successfully submitted")
            }
        }
    }
}
