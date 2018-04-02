//
//  viewStudents.swift
//  rollCall
//
//  Created by Kevin Vallejo on 3/26/18.
//  Copyright © 2018 Vallejo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class viewStudents: UITableViewController {
    var studentData = [STUDENT]()
    var handle:DatabaseHandle?
    var ref:DatabaseReference?
    
  //  @IBOutlet var backbutton: UINavigationItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       // self.navigationItem.backBarButtonItem? = self.editButtonItem

        ref = Database.database().reference()
        fetchUsers()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

       
       //  self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return studentData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = studentData[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            //***Deleting from Database***
            Database.database().reference().child("data").child(studentData[indexPath.row].uid!).removeValue()
            // ***Deleting from object class***
            self.studentData.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            /*
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }   
 */
 
    }
      
}
    

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
    func fetchUsers()
        {
            handle = ref?.child("data").observe(DataEventType.childAdded, with: { (DataSnapshot) in
                if let Dictionary  = DataSnapshot.value as? [String: AnyObject]
                {
                    print(Dictionary)
                    
                    let user = STUDENT()
                    let age = Dictionary["Age"]
                    let gradeLevel = Dictionary["Grade Level"]
                    let name = Dictionary["Name"]
                    let notes = Dictionary["Notes"]
                    let uid = Dictionary["uid"]
                    
                    user.name = name as? String
                    user.age = age as? String
                    user.gradeLevel = gradeLevel as? String
                    user.notes = notes as? String
                    user.uid = uid as? String
                    
                    self.studentData.append(user)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
        }
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
