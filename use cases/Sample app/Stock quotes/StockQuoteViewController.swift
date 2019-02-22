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
    @IBOutlet weak var stockDataResultsTextField: UITextView!
    
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

    private func stockDataText(from stock: StockInfo) -> String {
        var stockDataText = ""
        if let currentStock = state.currentStockInfo {
            stockDataText.append("symbol = \(String(describing: currentStock.symbol))")
            stockDataText.append("name = \(String(describing: currentStock.name))")
            stockDataText.append("primaryExchange = \(String(describing: currentStock.primaryExchange))")
            stockDataText.append("sector = \(String(describing: currentStock.sector))")
            stockDataText.append("latestPrice = \(String(describing: currentStock.latestPrice))")
            stockDataText.append("previousClose = \(String(describing: currentStock.previousClose))")
            stockDataText.append("change = \(String(describing: currentStock.change))")
            stockDataText.append("changePercent = \(String(describing: currentStock.changePercent))%")
            stockDataText.append("week52High = \(String(describing: currentStock.week52High))")
            stockDataText.append("week52Low = \(String(describing: currentStock.week52Low))")
            stockDataText.append("latestVolume = \(String(describing: currentStock.latestVolume))")
        }
    }
    
    private func updateHistoryState(with state: AppState) {
        self.updateHistoryNavigationButtonsState(with: state)
        self.updateHistoryCountLabel(with: state)
    }
    
    private func updateHistoryNavigationButtonsState(with state: AppState) {
        self.buttonGoBack.isEnabled = state.stocksHistory.canGoBack
        self.buttonGoForward.isEnabled = state.stocksHistory.canGoForward
    }

    private func updateStockDataText(stockDataText: String) {
      let stockDataText = self.stockDataText(from: <#T##AppState#>)
                self.stockDataResultsTextField.text = stockDataText
    }
    
    
    private func updateHistoryCountLabel(with state: AppState) {
        let historyCountLabelText: String
        if state.stocksHistory.currentIndex != nil {
            let numberOfCurrentHistoryCalculation = state.stocksHistory.currentIndex! + 1
            let numberOfHistoryCalculations = state.stocksHistory.history.count
            historyCountLabelText = "\(numberOfCurrentHistoryCalculation) of \(numberOfHistoryCalculations)"
        } else {
            historyCountLabelText = EMPTY_STRING
        }
        self.historyCountLabel.text = historyCountLabelText
    }
    

    // MARK: - AppState
    
    func update(_ state: AppState, mostRecentAction: Action) {
        switch mostRecentAction {
        case .stockQuoteServiceResponse(_, _):
            if let result = state.currentCalculation?.result {
//                let resultText = "\(result)"
//                self.resultLabel.text = resultText
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
