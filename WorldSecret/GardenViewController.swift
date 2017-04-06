//
//  GardenViewController.swift
//  WorldSecret
//
//  Created by JOSE ANTONIO MARTINEZ FERNANDEZ on 09/03/2017.
//  Copyright © 2017 joamafer. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let enterPipe = Notification.Name("enterPipe")
}

class GardenViewController: UIViewController, StageProtocol {
    
    @IBOutlet weak var lilyImageView: UIImageView!
    @IBOutlet weak var pipeImageView: UIImageView!
    @IBOutlet weak var frogBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var frogImageView: UIImageView!
    
    weak var delegate: StageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(GardenViewController.actionDone), name: Notification.Name.enterPipe, object: nil)
        
        UIView.transition(with: lilyImageView, duration: 1.0, options: [.repeat, .autoreverse], animations: {
            self.lilyImageView.image = UIImage(named: "lilyFlipped")
        }, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        frogBottomConstraint.constant = 10
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func actionDone(notification: Notification) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.frogImageView.center = self.pipeImageView.center
        }, completion: { _ in
            self.delegate?.goToNextStage()
        })
    }
    
}

