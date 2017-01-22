//
//  MainVC.swift
//  DreamLister
//
//  Created by New on 1/19/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import UIKit
import CoreData


//FRC (Fetch Results Controller) Collects all info about the results and keep collection of data low. It also tells the controller’s fetch results have been changed due to an add, remove, move, or update operations. Essentially gets the results but, in batches to keep data requests low.

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {


    //Outlets from the ViewController
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!

    //When working with FRC you must: 1) Have a variable for the FRC, 2) tell it what entity or data classes we will be working with (NSManagedObject)

    //Dont forget the "!" to unwrap

    var controller: NSFetchedResultsController<Item>!

    override func viewDidLoad() {
        super.viewDidLoad()

        //The tableview will receive and delegate information from this VC

        tableView.delegate = self
        tableView.dataSource = self

        //These functions must be here because it will be called as the view loads
        generateTestData()
        attemptFetch()


        // Do any additional setup after loading the view, typically from a nib.
    }


    //Methods that will be used in the table view

    //* FRC works with sections made up of rows. Instead of making an array, the FRC understands and sets the number of rows and information to return
        //Puts the cell in a specific location



    // When we call "CellForRowAt" we create a cell, passing that into configure cell function, then passing it into the configure cell object inside the function that is handled in the ItemCell custom class

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //configures the cell to update and be reusable
        // In order to work, we had to set an Identifier. The itemcell gets the identifier "ItemCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)

        return cell
    }

    func configureCell (cell: ItemCell, indexPath: NSIndexPath) {
        //update cell and calls it from two locations

        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)




    }
    //Makes the number of rows in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        //If there if there are sections, grab info, count them and return the number of objects. If they aren't any, return zero
        if let sections = controller.sections {
            let sectionsInfo = sections[section]
            return sectionsInfo.numberOfObjects
        }

        return 0
    }

        //Returns the number of cells in the view.
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0

    }

    //Makes sure the row height stays as it should.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

        //Creates FetchRequest Variable, tells what will be fetched, and then telling to go fetch
        //This will be pass

    func attemptFetch() {

        //the fetch request will be working with
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()


        //Sorts data. The Key "Created" comes from the entity Created which will be our timestamp. Look at NSManagedObjects in xcDatamodled, the entity ITEM has an attribute called "created"

        //How we sort
        let dateSort = NSSortDescriptor(key: "created", ascending: false)

        //fetch request expects an array.
        fetchRequest.sortDescriptors = [dateSort]


        //Instantiate the fetch request controller. Initializes it and passes in what will be in the fetch request.

        //NSManagedObjectContext is in the persistent Container. This is the template of how things will come back. We have passed the information into it.
        let controller  = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)


        self.controller = controller

        //Error Checking. Tries to fetch and will return error if fetch is unsuccessful.
        //Remember this for future reference. 

        do {
            try controller.performFetch()

        } catch {

            let error = error as NSError
            print ("\(error)")
        }
    }

        //Whenever the table view will update, this will listen for changes and make them for you.
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

        //Inserts, deletes, update, or modifies tableview as we scroll.
        tableView.beginUpdates()
    }

    //If the content has been updated and there is nothing more, end updates. Tableview.endupdates does this.
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    //Listens for changes (insert, delete, move, and update)
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {


        //WHat happens when you create a new item. This is what happens when we save item
        switch (type) {

            //What happens for the Insert when inserting data into table view
        case.insert:
            if let indexPath = newIndexPath {

                //When we insert a new item (inserted at the new index path) it will animate with a fade in.
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell

                //Whenever the cell updates, the new cell goes through the configureCell function
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }

            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
    }
}
    //Inputs test data into the tableview
    func generateTestData() {

        let item = Item(context: context)
        item.title = "Yacht"
        item.price = 2000000
        item.details = "I can't wait to own a Yacht! Sailing would be lit!"

        let item2 = Item(context: context)
        item2.title = "Porche Panaroma"
        item2.price = 80000
        item2.details = "I can't wait to own a Porche! Crusing on the FDR drive would be amazing!"

        let item3 = Item(context: context)
        item3.title = "Penthouse"
        item3.price = 5000000
        item3.details = "I can't wait to own a penthouse! Parties would be the dopest ever!!!"

        // Allows users to save content offline
        ad.saveContext()
    }


}
