//
//  ContentVC.swift
//  ToDoList
//
//  Created by Tiku on 3/6/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

struct ToDoModel {
    let uid: String
    let title: String
    let description: String
}

class ContentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var data: [ToDoModel] = []
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTableViewCell")
        
        ref = Database.database().reference()
        
        databaseHandle = ref?.child("ToDoList").observe( .childAdded, with: { (snapShot) in
            guard let value = snapShot.value as? [String: Any] else { return }
            
            let title = value["title"] as? String
            let description = value["description"] as? String
            let model = ToDoModel(uid: snapShot.key, title: title ?? "", description: description ?? "")
            self.data.append(model)
            self.tableView.reloadData()
        })
        
        databaseHandle = ref?.child("ToDoList").observe( .childRemoved, with: { (snapShot) in
            if let index = self.data.firstIndex(where: { $0.uid == snapShot.key }) {
                self.data.remove(at: index)
                self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell", for: indexPath) as! ContentTableViewCell
        cell.titleLabel.text = data[indexPath.row].title
        cell.descLabel.text = data[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // remove elements
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ref?.child("ToDoList").child(data[indexPath.row].uid).removeValue()
        }
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let dvc = storyboard.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = dvc
            
        } catch {
            print("Error ")
        }
    }
}
