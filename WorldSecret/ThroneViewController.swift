//
//  ThroneViewController.swift
//  WorldSecret
//
//  Created by JOSE ANTONIO MARTINEZ FERNANDEZ on 09/03/2017.
//  Copyright © 2017 joamafer. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let saySlogan = Notification.Name("saySlogan")
}

class ThroneViewController: UIViewController, StageProtocol {
    
    weak var delegate: StageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(GardenViewController.actionDone), name: Notification.Name.saySlogan, object: nil)
    }
    
    func actionDone(notification: Notification) {
        switch notification.name.rawValue {
        case Notification.Name.saySlogan.rawValue:
            let confettiView = ConfettiView(frame: self.view.bounds)
            confettiView.type = .Confetti
            view.addSubview(confettiView)
            confettiView.startConfetti()
        default:
            break
        }
    }
    
}

