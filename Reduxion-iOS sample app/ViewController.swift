//
//  ViewController.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 9/18/18.
//  Copyright © 2018 Ron Diamond. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AppStateSubscriber {

    var appStateSubscriberIdentifier: String = ""

    @IBOutlet weak var operand1TextField: UITextField!
    @IBAction func operand1EditingDidEnd(_ sender: Any) {
        print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
    }
    @IBOutlet weak var operand2TextField: UITextField!
    @IBAction func operand2EditingDidEnd(_ sender: Any) {
        print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
    }
    @IBOutlet weak var calculationTypeSegmentedControl: UISegmentedControl!
    @IBAction func buttonCalculateTapped(_ sender: Any) {
        print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
    }
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogicCoordinator.sharedInstance.subscribe(self)
    }

    deinit {
        LogicCoordinator.sharedInstance.unsubscribe(self)
    }
    
    
    // MARK: - AppState
    
    func update(_ state: AppState, mostRecentAction: Action) {
        switch mostRecentAction {
        case .performCalculation(_):
            let resultText = "\(state.currentCalculation.result)"
            self.resultLabel.text = resultText
        default:
            break
        }
    }

}

