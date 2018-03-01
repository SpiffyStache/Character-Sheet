//
//  PopUpViewController.swift
//  Player Sheet
//
//  Created by Robbie Cravens on 2/2/18.
//  Copyright © 2018 Robbie Cravens. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var closeButtonTapped: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var discriptionTextBox: UITextView!
    @IBOutlet weak var gearTitleLabel: UILabel!
    @IBOutlet weak var inventoryScrollView: UIScrollView!
    @IBOutlet weak var inventoryStackView: UIStackView!
    @IBOutlet weak var inventoryContainingView: UIView!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var gearDiscPlaceholderLabel: UILabel!
    weak var gearDelegate: GearDelegate?
    var gear: Gear!
    var restoredTitle: String!
    var restoredDiscription: String!
    var textFieldArray = [UITextField]()
    var inventoryButtonArray = [UIButton]()
    var InventoryStructArray = [Inventory]()
    let inventorySize = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            nameTextField.text = restoredTitle
            discriptionTextBox.text = restoredDiscription
//            stackViewHeightConstraint.constant = CGFloat(30 * inventorySize)
        
        switch gear {
        case .inventory:
            discriptionTextBox.isHidden = true
            discriptionTextBox.isEditable = false
            nameTextField.text = "Inventory"
            nameTextField.isHidden = true
            nameTextField.isEnabled = false
            gearDiscPlaceholderLabel.isHidden = true
           
            //add text fields to array and then add that array to the stack view
            for index in 1...inventorySize {
                
                let horizontalInventoryStackView = UIStackView()
                horizontalInventoryStackView.axis = .horizontal
                horizontalInventoryStackView.distribution = .fill
                horizontalInventoryStackView.spacing = 8
                
                let customTextField = UITextField()
                customTextField.layer.backgroundColor = UIColor.white.cgColor
                customTextField.placeholder = "Empty Slot"
                customTextField.layer.borderWidth = 0.25
                customTextField.layer.cornerRadius = 5.0
                customTextField.layer.borderColor = UIColor.lightGray.cgColor
                customTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
                customTextField.tag = index
                
                let inventoryDiscriptionButton = UIButton(type: .system)
                inventoryDiscriptionButton.layer.borderWidth = 0.5
                inventoryDiscriptionButton.layer.cornerRadius = 5.0
                inventoryDiscriptionButton.layer.borderColor = UIColor.lightGray.cgColor
                inventoryDiscriptionButton.layer.backgroundColor = UIColor.white.cgColor
                inventoryDiscriptionButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
                inventoryDiscriptionButton.setImage(#imageLiteral(resourceName: "compose-icon-1"), for: .normal)
                inventoryDiscriptionButton.widthAnchor.constraint(equalToConstant: 40).isActive = true

                textFieldArray.append(customTextField)
                inventoryButtonArray.append(inventoryDiscriptionButton)
                horizontalInventoryStackView.addArrangedSubview(customTextField)
                horizontalInventoryStackView.addArrangedSubview(inventoryDiscriptionButton)
                inventoryStackView.addArrangedSubview(horizontalInventoryStackView)
            }
            
        default:
            inventoryScrollView.isHidden = true
            inventoryContainingView.isHidden = true
            inventoryStackView.isHidden = true
            hideGearLabel()
            
        }
        self.showAnimate()
    }
    
    func hideGearLabel() {
        if self.discriptionTextBox.text == "" {
        gearDiscPlaceholderLabel.isHidden = false
        } else {
            gearDiscPlaceholderLabel.isHidden = true
        }
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    @IBAction func closePopupTapped(_ sender: Any) {
        if nameTextField.text == "" && gear != .inventory {
            
            //ADD "NONE" OPTION TO SET WEAPON NAME TO == current gear enum as a string
            let notEnoughCharactersAlert = UIAlertController(title: "Alert", message: "Please enter a name.", preferredStyle: UIAlertControllerStyle.alert)
            notEnoughCharactersAlert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default) { (_) in
            })
            self.present(notEnoughCharactersAlert, animated: true, completion: nil)
        } else {
            self.removeAnimate()
        }
        guard let userGearNameText = nameTextField.text?.trimmingCharacters(in: .whitespaces) else {
            fatalError("Expected text")
        }
        guard let userDiscriptionText = discriptionTextBox.text?.trimmingCharacters(in: .whitespaces) else {
            fatalError("Expected text")
        }
        gearDelegate?.popUpViewControllerDidEnterName(userGearName: userGearNameText, userDiscription: userDiscriptionText, forGear: gear)
        
        for textField in textFieldArray {
            let InventoryItem = Inventory(position: textField.tag, inventoryText: textField.text)
            InventoryStructArray.append(InventoryItem)
        }
    }
}

struct Inventory {
    let position: Int
    let inventoryText: String?
}
