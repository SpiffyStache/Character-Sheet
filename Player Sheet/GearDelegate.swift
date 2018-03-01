//
//  GearDelegate.swift
//  Player Sheet
//
//  Created by Robbie Cravens on 2/2/18.
//  Copyright © 2018 Robbie Cravens. All rights reserved.
//

import Foundation

protocol GearDelegate: class {
    
    func popUpViewControllerDidEnterName(userGearName: String, userDiscription: String, forGear gear: Gear)
    
}
