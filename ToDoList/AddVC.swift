//
//  AddVC.swift
//  ToDoList
//
//  Created by Tiku on 4/6/22.
//

import UIKit
import FirebaseDatabase

class AddVC: UIViewController {
    
    @IBOutlet weak var addTitle: UITextField!
    @IBOutlet weak var addDescription: UITextField!
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

    }

    @IBAction func addTaskAction(_ sender: UIButton) {
      
        self.ref.child("ToDoList").childByAutoId().setValue([
            "title": addTitle.text,
            "description": addDescription.text
        ])
        showContentVC()
    }
    private func showContentVC() {
        dismiss(animated: true, completion: nil)
    }
    
}
