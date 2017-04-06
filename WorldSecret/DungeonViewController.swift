//
//  DungeonViewController.swift
//  WorldSecret
//
//  Created by JOSE ANTONIO MARTINEZ FERNANDEZ on 09/03/2017.
//  Copyright © 2017 joamafer. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let shoutClearScore = Notification.Name("shoutClearScore")
}

class DungeonViewController: UIViewController, StageProtocol {
    
    weak var delegate: StageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(GardenViewController.actionDone), name: Notification.Name.shoutClearScore, object: nil)
    }
    
    func actionDone(notification: Notification) {
        self.performSegue(withIdentifier: "toThrone", sender: nil)
    }
    
}
