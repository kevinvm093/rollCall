//
//  attendance.swift
//  rollCall
//
//  Created by Kevin Vallejo on 3/28/18.
//  Copyright © 2018 Vallejo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class attendance: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var bar:Bool = false
    var studentName:[String] = []
    var studentData = [STUDENT]()
    var filtered = [STUDENT]()
    var handle:DatabaseHandle?
    var handle2:UInt!
    var ref:DatabaseReference?
    var dict = [String: STUDENT]()
    var text: String = ""
    
    @IBOutlet var studentTable: UITableView!
    


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if bar
        {
            return filtered.count
        }
        return studentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        if bar
        {
            cell.textLabel?.text = filtered[indexPath.row].name
            return cell
        }
        
        cell.textLabel?.text = studentData[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
        curr_student.text = "Selected Student: "
        if bar
        {
            curr_student.text = (curr_student.text ?? "") + filtered[indexPath.row].name!
        }
        curr_student.text = (curr_student.text ?? "") + studentData[indexPath.row].name!
 */
        
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete
        {
            if bar
            {
                let key = filtered[indexPath.row].uid!
                Database.database().reference().child("data").child(filtered[indexPath.row].uid!).removeValue()
                self.filtered.remove(at: indexPath.row)
                
                var i:Int = 0;
                for studentData in studentData
                {
                    if studentData.uid == key
                    {
                        self.studentData.remove(at: i)
                        break
                    }
                    i += 1
                }
            }
            else {
                //***Deleting from Database***
                Database.database().reference().child("data").child(studentData[indexPath.row].uid!).removeValue()
                // ***Deleting from object class***
                self.studentData.remove(at: indexPath.row)
            }
            self.studentTable.deleteRows(at: [indexPath], with: .automatic)
            
        }
        studentTable.reloadData()
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
