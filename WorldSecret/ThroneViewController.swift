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
    
    @IBOutlet weak var panelImageView: UIImageView!
    @IBOutlet weak var lilyImageView: UIImageView!
    @IBOutlet weak var knightImageView: UIImageView!
    @IBOutlet weak var frogImageView: UIImageView!
    @IBOutlet weak var kissLabel: UILabel!
    @IBOutlet weak var panelTopConstraint: NSLayoutConstraint!
    
    weak var delegate: StageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ThroneViewController.actionDone), name: Notification.Name.saySlogan, object: nil)
    }
    
    func actionDone(notification: Notification) {
        switch notification.name.rawValue {
        case Notification.Name.saySlogan.rawValue:
            UIView.animate(withDuration: 3.0, delay: 1.0, options: .curveEaseInOut, animations: { 
                self.lilyImageView.center = CGPoint(x: self.knightImageView.center.x - 200, y: self.knightImageView.center.y)
            }, completion: { _ in
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: { 
                    self.kissLabel.alpha = 1.0
                }, completion: { _ in
                    self.kissLabel.alpha = 0
                    
                    UIView.animate(withDuration: 0.5, animations: { 
                        self.frogImageView.alpha = 0.0
                        self.knightImageView.alpha = 1.0
                    }, completion: { _ in
                        let confettiView = ConfettiView(frame: self.view.bounds)
                        confettiView.type = .Confetti
                        self.view.addSubview(confettiView)
                        confettiView.startConfetti()
                        
                        self.panelTopConstraint.constant = -10.0
                        UIView.animate(withDuration: 2.0, delay: 1.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: { 
                            self.view.layoutIfNeeded()
                        }, completion: nil)
                    })
                })
            })
            
        default:
            break
        }
    }
    
}

