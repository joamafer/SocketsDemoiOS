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
    
    @IBOutlet weak var klausImageView: UIImageView!
    @IBOutlet weak var fromBottomConstraint: NSLayoutConstraint!
    
    weak var delegate: StageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(DungeonViewController.actionDone), name: Notification.Name.shoutClearScore, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fromBottomConstraint.constant = 20.0
        UIView.animate(withDuration: 3.0, delay: 2.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func actionDone(notification: Notification) {
        UIView.transition(with: self.klausImageView, duration: 1.0, options: .curveEaseOut, animations: { 
            self.klausImageView.image = UIImage(named: "KlausHappy")
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
                self.delegate?.goToNextStage()
            })
        }
    }
    
}
