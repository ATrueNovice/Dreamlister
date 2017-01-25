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

    override func viewDidLoad() {
        super.viewDidLoad()

        storePicker.delegate = self
        storePicker.dataSource = self

        //removes the DreamLister name from the navigation bar
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem (title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }



        //This code puts the store names in the array. But, when we add the Store(context: context) it puts the store names into core data to be used later offline.
        let store  = Store(context: context)
        store.name = "Best Buy"
        let store2  = Store(context: context)
        store2.name = "Tesla Dealership"
        let store3  = Store(context: context)
        store3.name = "Circuit City"
        let store4  = Store(context: context)
        store4.name = "Target"
        let store5  = Store(context: context)
        store5.name = "Amazon"
        let store6  = Store(context: context)
        store6.name = "Sears"
        let store7  = Store(context: context)
        store7.name = "Kmart"
        let store8  = Store(context: context)
        store8.name = "Ebay"

//        ad.saveContext()

        //Calls the get stores function
        getStores()



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

    }


