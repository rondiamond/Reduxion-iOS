//
//  ViewController.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 9/18/18.
//  Copyright © 2018-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import UIKit

class StockQuoteViewController: UIViewController, AppStateSubscriber, UITextFieldDelegate {
    var appStateSubscriberIdentifier: String = ""

    // MARK: - IBOutlets

    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var stockFetchDataButton: UIButton!
    @IBOutlet weak var stockInfoResultsTextField: UITextView!
    @IBOutlet weak var historyCountLabel: UILabel!
    @IBOutlet weak var buttonGoBack: UIButton!
    @IBOutlet weak var buttonGoForward: UIButton!

    
    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.symbolTextField.delegate = self
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.stockFetchDataTapped(textField)
        return true
    }
    
    @IBAction func stockFetchDataTapped(_ sender: Any) {
        if ((self.symbolTextField.text?.count)! > 0) {
            let symbol = self.symbolTextField.text!
            LogicCoordinator.performAction(Action.stockQuoteServiceRequest(symbol: symbol))
        }
    }
    
    
    // MARK: - Stock info
    
    private func updateStockInfoText(with state: AppState) {
        let stockInfo = state.dataModel.stocksHistory.currentStock
        self.stockInfoResultsTextField.text = stockInfoText(from: stockInfo)
    }

    private func stockInfoText(from stockInfo: DataModel.StockInfo?) -> String {
        var stockInfoText = ""
        if let stockInfo = stockInfo {
            stockInfoText.append("symbol = \(String(describing: stockInfo.symbol))\n")
            stockInfoText.append("name = \(String(describing: stockInfo.name))\n")
            stockInfoText.append("primaryExchange = \(String(describing: stockInfo.primaryExchange))\n")
            stockInfoText.append("sector = \(String(describing: stockInfo.sector))\n")
            stockInfoText.append("latestPrice = \(String(describing: stockInfo.latestPrice))\n")
            stockInfoText.append("previousClose = \(String(describing: stockInfo.previousClose))\n")
            stockInfoText.append("change = \(String(describing: stockInfo.change))\n")
            stockInfoText.append("changePercent = \(String(describing: stockInfo.changePercent))%\n")
            stockInfoText.append("week52High = \(String(describing: stockInfo.week52High))\n")
            stockInfoText.append("week52Low = \(String(describing: stockInfo.week52Low))\n")
            stockInfoText.append("latestVolume = \(String(describing: stockInfo.latestVolume))\n")
        }
        return stockInfoText
    }
    
    
    // MARK: - History navigation
    
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
        self.buttonGoBack.isEnabled = state.dataModel.stocksHistory.canGoBack
        self.buttonGoForward.isEnabled = state.dataModel.stocksHistory.canGoForward
    }
    
    private func updateHistoryCountLabel(with state: AppState) {
        let historyCountLabelText: String
        if state.dataModel.stocksHistory.currentIndex != nil {
            let numberOfCurrentHistoryCalculation = state.dataModel.stocksHistory.currentIndex! + 1
            let numberOfHistoryCalculations = state.dataModel.stocksHistory.history.count
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
            self.updateStockInfoText(with: state)
            self.updateHistoryState(with: state)
            break
        case .goBackInHistory(), .goForwardInHistory():
            self.updateHistoryState(with: state)
            break
        default:
            break
        }
    }
}
