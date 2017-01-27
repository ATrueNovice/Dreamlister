//
//  ItemDetails.swift
//  DreamLister
//
//  Created by New on 1/23/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import UIKit
import CoreData

//REmember to import the UI Protocols. In this case it is UI Pickerview Source and Delegateretret

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!

    //Will hold the array of stores
    var stores = [Store]()
    var itemToEdit: Item? //Question mark makes it an optional. This variable will hold the data that we will edit

    override func viewDidLoad() {
        super.viewDidLoad()

        storePicker.delegate = self
        storePicker.dataSource = self

        //removes the DreamLister name from the navigation bar
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem (title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }



        //This code puts the store names in the array. But, when we add the Store(context: context) it puts the store names into core data to be used later offline.
//        let store  = Store(context: context)
//        store.name = "Best Buy"
//        let store2  = Store(context: context)
//        store2.name = "Tesla Dealership"
//        let store3  = Store(context: context)
//        store3.name = "Circuit City"
//        let store4  = Store(context: context)
//        store4.name = "Target"
//        let store5  = Store(context: context)
//        store5.name = "Amazon"
//        let store6  = Store(context: context)
//        store6.name = "Sears"
//        let store7  = Store(context: context)
//        store7.name = "Kmart"
//        let store8  = Store(context: context)
//        store8.name = "Ebay"
//
//        ad.saveContext()

        //Calls the get stores function
        getStores()


        //if we have passed in an existing item's data we are going to load that in the main view
        if itemToEdit != nil {
            loadItemData()
        }



    }
    //Sets the title for each row in the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        //sets the picker to whatever row user has chosen
        let store = stores[row]
        return store.name
    }

    //Sets the number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }

    //How many columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    //Updates the UI label when selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {


        //Will update
    }


    func getStores() {

        //Places a fetch request to pull the data even while offline for the stores.
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()

        do {
            //Set the store array to the result we get back.
            self.stores = try context.fetch(fetchRequest)

            //Reloads all data back into the store picker.
            self.storePicker.reloadAllComponents()


        } catch {
            //handle it

        }
        }

        //We are going to put the details by inserting them in the NSManagedContent object. Then save it to database.
    @IBAction func savePressed(_ sender: UIButton) {

        //How we insert a object into a managed object context. We declear it as the entity as it self. Context is where the entities are stored.

        //Make sure that we update the existing cell instead of adding a new one. 
        var item: Item!

            if itemToEdit == nil {
                item = Item(context: context)
            }else {
                item = itemToEdit
            }


        //Next we in assign each attribute for the items
        //Title price and details are attributes of the Item that we in the line above. Now we insert this new data into that entity

        if let title = titleField.text {
            item.title = title
        }


        //Turned to nsstring so that we can use ns attributes

        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }

        if let details = detailsField.text {

            item.details = details
        }

        //Store is already an entity. It is the array above. We have already put the information in the store. Now we are assigning a store via relationship of the item.


        //In component address the columns. We only have one column and we want it to pull from there.
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
            ad.saveContext()

            //Dismisses view controller after button is pressed.
        _ = navigationController?.popViewController(animated: true)


    }

    //When we pass an item, we load it into the view 
    func loadItemData() {

        if let item = itemToEdit{

            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details

            if let store = item.toStore {
                var index = 0
                repeat {

                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)

                        break
                    }
                    index += 1

                }while (index < stores.count)
            }
        }

    }


}

















    


