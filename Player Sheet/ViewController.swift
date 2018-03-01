//
//  ViewController.swift
//  Player Sheet
//
//  Created by Robbie Cravens on 1/30/18.
//  Copyright © 2018 Robbie Cravens. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GearDelegate {
    
    @IBOutlet weak var threeAttributesLabel: UILabel!
    @IBOutlet weak var weaponOneButton: UIButton!
    @IBOutlet weak var weaponTwoButton: UIButton!
    @IBOutlet weak var attireButton: UIButton!
    @IBOutlet weak var accessoryButton: UIButton!
    @IBOutlet weak var inventoryButton: UIButton!
    @IBOutlet weak var weaponOneLabel: UILabel!
    @IBOutlet weak var weaponTwoLabel: UILabel!
    @IBOutlet weak var attireLabel: UILabel!
    @IBOutlet weak var accessoryLabel: UILabel!
    @IBOutlet weak var inventoryLabel: UILabel!
    
    var weaponOne = String()
    var weaponTwo = String()
    var attire = String()
    var accessory = String()
    var inventory = String()
    var weaponOneDiscription = String()
    var weaponTwoDiscription = String()
    var attireDiscription = String()
    var accessoryDiscription = String()
    var inventoryDiscription = String()
    
    var threeAttribuesArray: [String] = ["???", "???", "???"]
    let gender = "Female "
    let race = "Tiefling, "
    let deity = "under Alterious"
   

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        UserDefaults.standard.set("name", forKey: UserDefaultsKeys.weaponOneName)
        
        threeAttribuesArray[0] = gender
        threeAttribuesArray[1] = race
        threeAttribuesArray[2] = deity
        
       self.threeAttributesLabel.text = threeAttribuesArray.joined()
       print(self.threeAttributesLabel.text as Any)
    }

    func popUpViewControllerDidEnterName(userGearName: String, userDiscription: String, forGear gear: Gear) {
        switch gear {
        case .weaponOne:
            weaponOneLabel.text = userGearName
            weaponOne = userGearName
            weaponOneDiscription = userDiscription
        case .weaponTwo:
            weaponTwoLabel.text = userGearName
            weaponTwo = userGearName
            weaponTwoDiscription = userDiscription
        case .attire:
            attireLabel.text = userGearName
            attire = userGearName
            attireDiscription = userDiscription
        case .accessories:
            accessoryLabel.text = userGearName
            accessory = userGearName
            accessoryDiscription = userDiscription
        case .inventory:
            inventoryLabel.text = userGearName
            inventory = userGearName
            inventoryDiscription = userDiscription
        }
    }
    
    //opens pop up view and displays view corisponding to the button pressed
    @IBAction func showGearViewController(_ sender: UIButton) {
        
        let gear: Gear
        let storedTitle: String
        let storedDiscription: String
        
        switch sender {
        case weaponOneButton:
            gear = .weaponOne
            storedTitle = weaponOne
            storedDiscription = weaponOneDiscription
        case weaponTwoButton:
            gear = .weaponTwo
            storedTitle = weaponTwo
            storedDiscription = weaponTwoDiscription
        case attireButton:
            gear = .attire
            storedTitle = attire
            storedDiscription = attireDiscription
        case accessoryButton:
            gear = .accessories
            storedTitle = accessory
            storedDiscription = accessoryDiscription
        case inventoryButton:
            storedTitle = inventory
            storedDiscription = inventoryDiscription
            gear = .inventory
        default:
            fatalError()
        }
        
        let popOverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "storyBoardPopUpID") as! PopUpViewController
        popOverViewController.gear = gear
        popOverViewController.gearDelegate = self
        popOverViewController.restoredTitle = storedTitle
        popOverViewController.restoredDiscription = storedDiscription
        self.addChildViewController(popOverViewController)
        popOverViewController.view.frame = self.view.frame
        self.view.addSubview(popOverViewController.view)
        popOverViewController.didMove(toParentViewController: self)
    }
}
