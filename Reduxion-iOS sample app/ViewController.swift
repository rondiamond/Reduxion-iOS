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
    @IBOutlet weak var historyCountLabel: UILabel!
    
    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogicCoordinator.sharedInstance.subscribe(self)
        
        let calculationLogic = CalculationLogic()
        LogicCoordinator.sharedInstance.add(logic: calculationLogic)    // TODO: REFACTOR
    }

    deinit {
        LogicCoordinator.sharedInstance.unsubscribe(self)
    }
    
    // MARK: - IBAction
    
    @IBAction func buttonCalculateTapped(_ sender: Any) {
        var operand1: Float = 0
        var operand2: Float = 0
        if operand1TextField.text!.count > 0 {
            operand1 = Float(operand1TextField.text!) ?? 0
        }
        if operand2TextField.text!.count > 0 {
            operand2 = Float(operand2TextField.text!) ?? 0
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
    
    @IBAction func buttonBackTapped(_ sender: Any) {
        LogicCoordinator.sharedInstance.performAction(.goBackCalculationHistory())
    }
    
    @IBAction func buttonForwardTapped(_ sender: Any) {
        LogicCoordinator.sharedInstance.performAction(.goForwardCalculationHistory())
    }

    private func updateHistoryState(with state: AppState) {
        self.updateHistoryNavigationButtonsState(with: state)
        self.updateHistoryCountLabel(with: state)
    }
    
    private func updateHistoryNavigationButtonsState(with state: AppState) {
        
    }

    private func updateHistoryCountLabel(with state: AppState) {
        
    }
    

    // MARK: - AppState
    
    func update(_ state: AppState, mostRecentAction: Action) {
        switch mostRecentAction {
        case .performCalculation(_):
            if let result = state.currentCalculation?.result {
                let resultText = "\(result)"
                print("[AppState] state.currentCalculation.result = \(resultText)\n")
                self.resultLabel.text = resultText
                self.updateHistoryState(with: state)
            }
        case .goBackCalculationHistory, .goForwardCalculationHistory:
            self.updateHistoryState(with: state)
            break
        default:
            break
        }
    }

}
