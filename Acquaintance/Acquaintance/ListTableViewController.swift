//
//  ListTableViewController.swift
//  Acquaintance
//
//  Created by zjajgyy on 2016/11/29.
//  Copyright © 2016年 zjajgyy. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    //var acqList = [Person("Ameir Al-Zoubi"), Person("Bill Dudney"), Person("Bob McCune"), Person("Brent Simmons"), Person("Cesare Rocchi"), Person("Chad Sellers"), Person("Conrad Stoll"), Person("Daniel Pasco"), Person("Jaimee Newberry"), Person("James Dempsey"), Person("Josh Abernathy"), Person("Justin Miller"), Person("Ken Auer"), Person("Kevin Harwood"), Person("Kyle Richter"), Person("Manton Reece"), Person("Marcus Zarra"), Person("Mark Pospesel"), Person("Matt Drance"), Person("Michael Simmons"), Person("Michele Titolo"), Person("Michael Simmons"), Person("Rene Cacheaux"), Person("Rob Napier"), Person("Scott McAlister"), Person("Sean McMains")]
    //var acqList = ["Ameir Al-Zoubi", "Bill Dudney", "Bob McCune", "Brent Simmons", "Cesare Rocchi", "Chad Sellers", "Conrad Stoll", "Daniel Pasco", "Jaimee Newberry", "James Dempsey", "Josh Abernathy", "Justin Miller", "Ken Auer", "Kevin Harwood", "Kyle Richter", "Manton Reece", "Marcus Zarra", "Mark Pospesel", "Matt Drance", "Michael Simmons", "Michele Titolo", "Michael Simmons", "Rene Cacheaux", "Rob Napier", "Scott McAlister", "Sean McMains"]
    var acqList = [Person]()
    var sampleList = [Person("Ameir Al-Zoubi"), Person("Bill Dudney"), Person("Bob McCune"), Person("Brent Simmons"), Person("Cesare Rocchi"), Person("Chad Sellers"), Person("Conrad Stoll"), Person("Daniel Pasco"), Person("Jaimee Newberry"), Person("James Dempsey"), Person("Josh Abernathy"), Person("Justin Miller"), Person("Ken Auer"), Person("Kevin Harwood"), Person("Kyle Richter"), Person("Manton Reece"), Person("Marcus Zarra"), Person("Mark Pospesel"), Person("Matt Drance"), Person("Michael Simmons"), Person("Michele Titolo"), Person("Michael Simmons"), Person("Rene Cacheaux"), Person("Rob Napier"), Person("Scott McAlister"), Person("Sean McMains")]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
//        for person in acqList {
//            if let name = person?.name {
//                person?.photo = UIImage(named: name)
//                person?.notes = "This is a memo for " + name
//            }
//        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Load any saved acquaitance, otherwise load sample data. 
        if let savedList = loadList() {
            acqList += savedList
        } else {
            // Load the sample data. 
            for person in sampleList {
                person!.photo = UIImage(named: person!.name)
                acqList.append(person!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return acqList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        let person = acqList[indexPath.row]
        // Configure the cell...
        if let photo = person.photo {
            cell.photoImageView.image = photo
        } else {
            cell.photoImageView.image = UIImage(named:"photoalbum")
        }
        //cell.nameLabel.text
        cell.nameLabel.text = person.name
        cell.notesLabel.text = person.notes
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    @IBAction func unwindToList(segue:UIStoryboardSegue) {
        if segue.identifier == "SaveToList",
            let detailViewController = segue.source as? DetailTableViewController, let person = detailViewController.person {
            if let selectedIndexPath = tableView.indexPathForSelectedRow { // Update an existing person.
                acqList[(selectedIndexPath as NSIndexPath).row] = person
                tableView.reloadRows(at: [selectedIndexPath], with: .none) } else {
                // Add a new person.
                let newIndexPath = IndexPath(row: acqList.count, section: 0)
                acqList.append(person)
                tableView.insertRows(at: [newIndexPath], with: .bottom) }
        }
        saveList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowDetail",
            let indexPath = tableView.indexPathForSelectedRow,
            let detailViewController = segue.destination as? DetailTableViewController {
            detailViewController.person = acqList[indexPath.row]
        }
    }

    func saveList() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(acqList, toFile: Person.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save the acquaintance list ...")
        }
    }
    
    func loadList() -> [Person]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Person.ArchiveURL.path) as? [Person]
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    

}
