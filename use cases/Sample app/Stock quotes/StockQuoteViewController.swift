//
//  ViewController.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 9/18/18.
//  Copyright © 2018-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import UIKit

class StockQuoteViewController: UIViewController, AppStateSubscriber {
    var appStateSubscriberIdentifier: String = ""

    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var stockFetchDataButton: UIButton!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var operand1TextField: UITextField!
    @IBOutlet weak var historyCountLabel: UILabel!
    @IBOutlet weak var buttonGoBack: UIButton!
    @IBOutlet weak var buttonGoForward: UIButton!
    
    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogicCoordinator.subscribe(self)
    }

    deinit {
        LogicCoordinator.unsubscribe(self)
    }
    
    // MARK: - IBAction
    
    
    @IBAction func symbolTextFieldValueChanged(_ sender: Any) {
        let hasText = ((sender as! UITextField).text!.count > 0)
        self.stockFetchDataButton.isEnabled = hasText
    }
    
    @IBAction func stockFetchDataTapped(_ sender: Any) {
        let symbol = (sender as! UITextField).text!
        LogicCoordinator.performAction(Action.stockQuoteServiceRequest(symbol: symbol))
    }
    
    @IBAction func buttonBackTapped(_ sender: Any) {
        LogicCoordinator.performAction(.goBackInHistory())
    }
    
    @IBAction func buttonForwardTapped(_ sender: Any) {
        LogicCoordinator.performAction(.goForwardInHistory())
    }

    private func updateHistoryState(with state: AppState) {
        self.updateHistoryNavigationButtonsState(with: state)
        self.updateHistoryCountLabel(with: state)
    }
    
    private func updateHistoryNavigationButtonsState(with state: AppState) {
        self.buttonGoBack.isEnabled = state.stocksHistory.canGoBack
        self.buttonGoForward.isEnabled = state.stocksHistory.canGoForward
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
