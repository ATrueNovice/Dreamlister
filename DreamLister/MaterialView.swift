//
//  MaterialView.swift
//  DreamLister
//
//  Created by New on 1/20/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import UIKit

//cant add bool inside so we add it before. It won't automatically select the material design

private var materialKey = false

extension UIView {

    @IBInspectable var materialDesign: Bool {

    //When a new view is added, users can decide to add the material design to view.
    get {
        return materialKey
    }
    set {

    materialKey = newValue

        //If materialKey is select we add shadow to the item.

        if materialKey {
            self.layer.masksToBounds = false
            self.layer.cornerRadius = 3.0
            self.layer.shadowOpacity = 0.8
            self.layer.shadowRadius = 3.0
            self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
        } else {
            //Does not add the shadow to non material Key selected items.
            self.layer.shadowRadius = 0
            self.layer.shadowOpacity = 0
            self.layer.shadowRadius = 0
            self.layer.shadowColor = nil
        }

        }
    }

}
