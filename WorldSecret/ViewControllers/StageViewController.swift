//
//  StageViewController.swift
//  WorldSecret
//
//  Created by JOSE ANTONIO MARTINEZ FERNANDEZ on 06/04/2017.
//  Copyright © 2017 joamafer. All rights reserved.
//

import UIKit

private let curtainsAnimationDuration: TimeInterval = 3

enum Stage {
    case forest
    case garden
    case dungeon
    case throne
}

protocol StageProtocol: class {
    weak var delegate: StageViewControllerDelegate? { get set }
}

protocol StageViewControllerDelegate: class {
    func goToNextStage()
}

class StageViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leftCurtainLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightCurtainTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var leftCurtainTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topCurtainTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var princeRicardoLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var princeRicardoLabel: UILabel!
    
    var forestViewController: ForestViewController!
    var gardenViewController: GardenViewController!
    var dungeonViewController: DungeonViewController!
    var throneViewController: ThroneViewController!
    
    var currentStage: Stage? {
        didSet {
            guard let currentStage = currentStage else {
                return
            }
            
            closeCurtains(completion: { _ in
                switch currentStage {
                case .forest:
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        self.princeRicardoLabel.alpha = 0.0
                    }) { _ in
                        self.princeRicardoLabel.removeFromSuperview()
                    }
                    
                    self.currentViewController = self.forestViewController
                case .garden:
                    self.currentViewController = self.gardenViewController
                case .dungeon:
                    self.currentViewController = self.dungeonViewController
                case .throne:
                    self.currentViewController = self.throneViewController
                }
            })
        }
    }
    
    var currentViewController: UIViewController? {
        didSet {
            oldValue?.removeChildViewController()
            
            if let currentVC = currentViewController {
                add(childViewController: currentVC, toView: containerView)
                (currentViewController as? StageProtocol)?.delegate = self
            }
            
            openCurtains(completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        forestViewController = mainStoryBoard.instantiateViewController(withIdentifier: String(describing: ForestViewController.self)) as! ForestViewController
        gardenViewController = mainStoryBoard.instantiateViewController(withIdentifier: String(describing: GardenViewController.self)) as! GardenViewController
        dungeonViewController = mainStoryBoard.instantiateViewController(withIdentifier: String(describing: DungeonViewController.self)) as! DungeonViewController
        throneViewController = mainStoryBoard.instantiateViewController(withIdentifier: String(describing: ThroneViewController.self)) as! ThroneViewController
        
        NotificationCenter.default.addObserver(self, selector: #selector(ForestViewController.actionDone), name: Notification.Name.startGame, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.princeRicardoLabelTopConstraint.constant = 0
        UIView.animate(withDuration: 3.0) { 
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Setup
    
    func closeCurtains(completion: ((Bool) -> Void)?) {
        if leftCurtainTrailingConstraint.isActive {
            completion?(true)
            return
        }
        
        leftCurtainLeadingConstraint.constant = 0
        rightCurtainTrailingConstraint.constant = 0
        topCurtainTopConstraint.constant = 0
        leftCurtainTrailingConstraint.isActive = true
        
        UIView.animate(withDuration: curtainsAnimationDuration, delay: 0, options: .curveEaseInOut, animations: { 
            self.view.layoutIfNeeded()
        }, completion: completion)
    }
    
    func openCurtains(completion: ((Bool) -> Void)?) {
        if !leftCurtainTrailingConstraint.isActive {
            completion?(true)
            return
        }
        
        leftCurtainLeadingConstraint.constant = -view.bounds.size.width
        rightCurtainTrailingConstraint.constant = -view.bounds.size.width
        topCurtainTopConstraint.constant = -view.bounds.size.height
        leftCurtainTrailingConstraint.isActive = false
        
        UIView.animate(withDuration: curtainsAnimationDuration, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: completion)
    }
    
    // MARK: - Notification
    
    func actionDone(notification: Notification) {
        switch notification.name.rawValue {
        case Notification.Name.startGame.rawValue:
            currentStage = .forest
        default:
            break
        }
    }

}

extension Notification.Name {
    static let startGame = Notification.Name("startGame")
}

extension StageViewController: StageViewControllerDelegate {
    
    func goToNextStage() {
        guard let unwrappedCurrentStage = currentStage else {
            return
        }
        
        switch unwrappedCurrentStage {
        case .forest:
            currentStage = .garden
        case .garden:
            currentStage = .dungeon
        case .dungeon:
            currentStage = .throne
        case .throne:
            break
        }
    }
    
}
