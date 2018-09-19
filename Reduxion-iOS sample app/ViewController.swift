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

    // MARK: - IBOutlets
    @IBOutlet weak var operand1TextField: UITextField!
    @IBOutlet weak var operand2TextField: UITextField!
    @IBOutlet weak var calculationTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var resultLabel: UILabel!

    
    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogicCoordinator.sharedInstance.subscribe(self)
    }

    deinit {
        LogicCoordinator.sharedInstance.unsubscribe(self)
    }

    
    // MARK: - IBActions
    
    @IBAction func operand1EditingDidEnd(_ sender: Any) {
        print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
    }

    @IBAction func operand2EditingDidEnd(_ sender: Any) {
        print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
    }

    @IBAction func buttonCalculateTapped(_ sender: Any) {
        print("\n \(self) \(#function) line \(#line); NSDate = \(NSDate.init().timeIntervalSince1970)")
        
        var operand1: Float = 0
        var operand2: Float = 0
        if let operand1Text = operand1TextField.text {
            operand1 = Float(operand1Text)!
        }
        if let operand2Text = operand2TextField.text {
            operand2 = Float(operand2Text)!
        }
        
        let calculationType: CalculationType
        switch self.calculationTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            calculationType = .addition
        case 1:
            calculationType = .subtraction
        case 2:
            calculationType = .multiplication
        case 3:
            calculationType = .division
        default:
            calculationType = .addition
        }
        
        LogicCoordinator.sharedInstance.performAction(Action.performCalculation(operand1: operand1, operand2: operand2, calculationType: calculationType))
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
