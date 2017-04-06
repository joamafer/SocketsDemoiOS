//
//  ForestViewController.swift
//  WorldSecret
//
//  Created by JOSE ANTONIO MARTINEZ FERNANDEZ on 09/03/2017.
//  Copyright © 2017 joamafer. All rights reserved.
//

import UIKit

private let initialAnimationDelay: TimeInterval = 3
private let afterHealthDuration: TimeInterval = 10
private let afterFrogDuration: TimeInterval = 8

extension Notification.Name {
    static let throwRock = Notification.Name("throwRock")
    static let helpWitch = Notification.Name("helpWitch")
}

class ForestViewController: UIViewController, StageProtocol {

    @IBOutlet weak var witchView: UIImageView!
    @IBOutlet weak var playerView: UIImageView!
    @IBOutlet weak var frogView: UIImageView!
    @IBOutlet weak var stoneImageView: UIImageView!
    @IBOutlet weak var pillLabel: UILabel!
    @IBOutlet weak var playerViewTrailingConstraint: NSLayoutConstraint!
    
    weak var delegate: StageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ForestViewController.actionDone), name: Notification.Name.throwRock, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ForestViewController.actionDone), name: Notification.Name.helpWitch, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + initialAnimationDelay) {
            self.playerViewTrailingConstraint.constant = 0.0
            UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                UIView.animate(withDuration: 2, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                    self.playerView.center = self.stoneImageView.center
                    self.playerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }, completion: nil)
            })
        }
    }
    
    func actionDone(notification: Notification) {
        
        switch notification.name.rawValue {
        case Notification.Name.throwRock.rawValue:
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                self.stoneImageView.alpha = 1.0
                self.stoneImageView.center = self.witchView.center
                self.stoneImageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }) { finished in
                self.stoneImageView.alpha = 0.0
                
                UIView.transition(with: self.playerView, duration: 2.0, options: .curveEaseInOut, animations: {
                    self.playerView.image = self.frogView.image
                }, completion:  { _ in
                    self.delegate?.goToNextStage()
                })
            }
        case Notification.Name.helpWitch.rawValue:
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                self.playerView.center = CGPoint(x: self.witchView.center.x + 200, y: self.witchView.center.y)
                self.playerView.transform = CGAffineTransform.identity
            }) { finished in
                self.pillLabel.alpha = 1.0
                self.view.layoutIfNeeded()
                UIView.transition(with: self.playerView, duration: 2.0, options: .curveEaseInOut, animations: {
                    self.witchView.image = UIImage(named: "witchHappy")
                }, completion:  { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + afterHealthDuration, execute: {
                        self.pillLabel.alpha = 0.0
                        UIView.transition(with: self.playerView, duration: 0.5, options: .curveEaseInOut, animations: {
                            self.playerView.alpha = 0.0
                            self.frogView.alpha = 1.0
                        }, completion:  { _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + afterFrogDuration, execute: {
                                self.delegate?.goToNextStage()
                            })
                        })
                    })
                })
            }
        default:
            break
        }
    }
    
}
