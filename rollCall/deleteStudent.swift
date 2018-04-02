//
//  deleteStudent.swift
//  Pods
//
//  Created by Kevin Vallejo on 2/23/18.
//
//

import UIKit
import Firebase
import FirebaseAuth

class deleteStudent: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

   // @IBOutlet var searchFilter: UITextField!
    var bar:Bool = false
    var studentName:[String] = []
    var studentData = [STUDENT]()
    var filtered = [STUDENT]()
    var handle:DatabaseHandle?
    var handle2:UInt!
    var ref:DatabaseReference?
    var dict = [String: STUDENT]()
    @IBOutlet var studentTable: UITableView!
    @IBOutlet var curr_student: UILabel!
    var text: String = ""
    @IBOutlet var searchBar: UISearchBar!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        fetchUsers()
        
        /*
        handle2 = ref?.observe(DataEventType.value, with: { (snapshot) in
            let temp = snapshot.value as! String
            self.studentName.append(temp)
            self.studentTable.reloadData()
            
        })
        */
       // ref?.observe(.value, with: {snapshot in
           // var temp:[student] = []})
        
        // Do any additional setup after loading the view.
    }
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
        curr_student.text = "Selected Student: "
        if bar
        {
            curr_student.text = (curr_student.text ?? "") + filtered[indexPath.row].name!
        }
        curr_student.text = (curr_student.text ?? "") + studentData[indexPath.row].name!
        
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
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        bar = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        bar = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        bar = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        bar = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        filtered = studentData.filter({ (text) -> Bool in
            let tmp: NSString = text.name! as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            bar = false;
        } else {
            bar = true;
        }
        studentTable.reloadData()
    }

    //override func tablevie
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
                    self.studentTable.reloadData()
                }
            }
        })
        


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
        }
    
}


