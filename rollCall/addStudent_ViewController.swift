//
//  addStudent_ViewController.swift
//  rollCall
//
//  Created by Kevin Vallejo on 2/21/18.
//  Copyright © 2018 Vallejo. All rights reserved.
//

import UIKit
import Firebase


class addStudent_ViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var nameText: UITextField!

    @IBOutlet var ageText: UITextField!
    @IBOutlet var noteText: UITextView!
    var name:String = ""
    var age:String = ""
    var notes:String = ""
    var kids:[String] = []
    let gradeLevel = ["Freshmen","Sophmore","Junior","Senor"]
    var level:String = ""
    var handle:DatabaseHandle?
    var ref:DatabaseReference?
    @IBOutlet var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference().child("data")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gradeLevel[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gradeLevel.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        return level = gradeLevel[row]
    }
    
    
    @IBAction func textFieldPressed(_ sender: UITextField)
    {
        nameText.text = ""
        nameText.textColor = UIColor.black
        noteText.text = ""
        noteText.textColor = UIColor.black
    }
    
    @IBAction func saveData(_ sender: UIButton)
    {
       name = nameText.text!
        age = ageText.text!
        notes = noteText.text!
        
       // let level = picker.selectedRow(inComponent: )
        
        
        
        if nameText.text != ""
        {
            let key = ref?.childByAutoId().key
            let student = ["Name": name,
                           "Age": age,
                           "Grade Level": level,
                           "Notes": notes,
                           "uid": key]
            
            
            ref?.child(key!).setValue(student)
         
        }
        
        nameText.text = "First and Last"
        nameText.isOpaque = false
        noteText.text = "Include any allergies, or specical instructions..."
        noteText.isOpaque = false
        ageText.text = ""
        picker.reloadAllComponents()
        
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
