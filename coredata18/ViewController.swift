//
//  ViewController.swift
//  coredata18
//
//  Created by Student P_04 on 19/12/19.
//  Copyright © 2019 Felix ITs. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let delegate = UIApplication.shared.delegate as!AppDelegate
var contactNumber = [String]()
var name = [String]()
 //var salary = [Double]()
   // var deparment = [String]()
   // var employenumber = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readFromCoreData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactNumber.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
       // cell.textLabel?.text = contactNumber[indexPath.row]
        cell.label1.text = contactNumber[indexPath.row]
        cell.label2.text = name[indexPath.row]
       // cell.label3.text = deparment[indexPath.row]
        
        return cell
    }
    

    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var employeeNotext: UITextField!
    
    @IBOutlet weak var employeeNametext: UITextField!
    
    @IBOutlet weak var employeecontactNotext: UITextField!
    
    @IBOutlet weak var salaryText: UITextField!
    
    @IBOutlet weak var departmentNotext: UITextField!
    
    func readFromCoreData()
    {
        let context = delegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Employee")
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                let str=data.value(forKey: "name")as! String
                print(str)
                name.append(str)
                let contact=data.value(forKey: "contactNo") as! String
                print(contactNumber)
                contactNumber.append(contact)
              //  let dept = data.value(forKey: "departmentNO") as!String
               // print(dept)
            }
            
            tblview.reloadData()

        }
        catch
        {
            print(error.localizedDescription)
        }
        
    }
    
    
    
    
    @IBAction func insertButton(_ sender: UIButton) {
        
     let context = delegate.persistentContainer.viewContext
        let empObject:NSObject=NSEntityDescription.insertNewObject(forEntityName:"Employee", into: context)
        empObject.setValue(self.employeeNotext.text, forKey: "employeeNo")
        empObject.setValue(self.employeeNametext.text, forKey: "name")
        empObject.setValue(self.employeecontactNotext.text, forKey: "contactNo")
        empObject.setValue(self.departmentNotext.text, forKey: "departmentNo")
        let formater = NumberFormatter()
        let sal = formater.number(from: self.salaryText.text!)as!Double
        empObject.setValue(sal, forKey: "salary")
        do
        {
            try context.save()
        }
        catch
        {
            print(error.localizedDescription)
        }
        print("Insert:Success")
        readFromCoreData()
        
        
    }
    
    @IBAction func UpdateButton(_ sender: UIButton) {
        let context = delegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Employee")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "name = %@", employeeNametext.text!)
        do
        {
            let result = try context.fetch(request)
            print(result)
            if (result.count<=1)
            {
                let object:NSManagedObject = result.first as! NSManagedObject
                print(object)
                object.setValue(employeecontactNotext.text, forKey: "contactNo")
                try context.save()
            }
        }
        catch
        {
            print(error.localizedDescription)
        }
        print("Update:Success")
    }
    
    @IBAction func DeleteButton(_ sender: UIButton) {
        let context = delegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Employee")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "name = %@", employeeNametext.text!)
        do
        {
            let result = try context.fetch(request)
            print(result)
            if (result.count<=1)
            {
                let object:NSManagedObject = result.first as! NSManagedObject
                print(object)
                //object.setValue(employeecontactNotext.text, forKey: "contactNo")
                context.delete(object)
                try context.save()
            }
        }
        catch
        {
            print(error.localizedDescription)
        }
        print("Delete:Success")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

