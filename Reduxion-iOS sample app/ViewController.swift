//
//  ViewController.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 9/18/18.
//  Copyright © 2018 Ron Diamond. All rights reserved.
//  Licensed per the LICENSE.txt file.
//

import UIKit

class ViewController: UIViewController, AppStateSubscriber {

    var appStateSubscriberIdentifier: String = ""

    // MARK: - IBOutlets
    @IBOutlet weak var operand1TextField: UITextField!
    @IBOutlet weak var operand2TextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var historyCountLabel: UILabel!
    @IBOutlet weak var buttonGoBack: UIButton!
    @IBOutlet weak var buttonGoForward: UIButton!
    
    @IBOutlet weak var calculationTypeSegmentedControl: UISegmentedControl!
    let calculationTypesBySegmentedIndex: [CalculationType] = [.addition, .subtraction, .multiplication, .division]
    

    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogicCoordinator.subscribe(self)
        
        let calculationLogic = CalculationLogic()
        LogicCoordinator.add(logic: calculationLogic)    // TODO: REFACTOR
        
        assert(calculationTypesBySegmentedIndex.count == self.calculationTypeSegmentedControl.numberOfSegments, "Fatal error: calculationTypesBySegmentedIndex.count == self.calculationTypeSegmentedControl.numberOfSegments")
    }

    deinit {
        LogicCoordinator.unsubscribe(self)
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
        let calculationType = calculationTypesBySegmentedIndex[self.calculationTypeSegmentedControl.selectedSegmentIndex]
        LogicCoordinator.performAction(Action.calculate(operand1: operand1, operand2: operand2, calculationType: calculationType))
    }
    
    @IBAction func buttonBackTapped(_ sender: Any) {
        LogicCoordinator.performAction(.goBackCalculationHistory())
    }
    
    @IBAction func buttonForwardTapped(_ sender: Any) {
        LogicCoordinator.performAction(.goForwardCalculationHistory())
    }

    private func updateHistoryState(with state: AppState) {
        self.updateHistoryNavigationButtonsState(with: state)
        self.updateHistoryCountLabel(with: state)
    }
    
    private func updateHistoryNavigationButtonsState(with state: AppState) {
        self.buttonGoBack.isEnabled = state.calculations.canGoBack
        self.buttonGoForward.isEnabled = state.calculations.canGoForward
    }

    private func updateCalculationParameters(with state: AppState) {
        if let currentCalculation = state.currentCalculation {
            self.operand1TextField.text = "\(currentCalculation.operand1)"
            self.operand2TextField.text = "\(currentCalculation.operand2)"
            self.calculationTypeSegmentedControl.selectedSegmentIndex = currentCalculation.calculationType.rawValue
            if let _ = currentCalculation.result {
                self.resultLabel.text = "\(currentCalculation.result!)"
            }
        }
    }
    
    private func updateHistoryCountLabel(with state: AppState) {
        let historyCountLabelText: String
        if state.calculations.currentIndex != nil {
            let numberOfCurrentHistoryCalculation = state.calculations.currentIndex! + 1
            let numberOfHistoryCalculations = state.calculations.history.count
            historyCountLabelText = "\(numberOfCurrentHistoryCalculation) of \(numberOfHistoryCalculations)"
        } else {
            historyCountLabelText = EMPTY_STRING
        }
        self.historyCountLabel.text = historyCountLabelText
    }
    

    // MARK: - AppState
    
    func update(_ state: AppState, mostRecentAction: Action) {
        switch mostRecentAction {
        case .calculate(_):
            if let result = state.currentCalculation?.result {
                let resultText = "\(result)"
                print("[AppState] state.currentCalculation.result = \(resultText)\n")
                self.resultLabel.text = resultText
                self.updateHistoryState(with: state)
            }
        case .goBackCalculationHistory, .goForwardCalculationHistory:
            self.updateCalculationParameters(with: state)
            self.updateHistoryState(with: state)
            break
        default:
            break
        }
    }

}
