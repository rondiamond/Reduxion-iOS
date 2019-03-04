//
//  ViewController.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 9/18/18.
//  Copyright © 2018-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

import UIKit

let alphaDimValue: CGFloat   = 0.8
let alphaFullValue: CGFloat  = 1.0


class StockQuoteViewController: UIViewController, AppStateSubscriber, UITextFieldDelegate {
    var appStateSubscriberIdentifier: String = ""

    // MARK: - IBOutlets

    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var stockFetchDataButton: UIButton!
    @IBOutlet weak var stockInfoResultsTextField: UITextView!
    @IBOutlet weak var historyCountLabel: UILabel!
    @IBOutlet weak var buttonGoBack: UIButton!
    @IBOutlet weak var buttonGoForward: UIButton!
    @IBOutlet weak var buttonClearHistory: UIButton!
    
    
    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.symbolTextField.delegate = self
        LogicCoordinator.subscribe(self, updateWithCurrentAppState: true)
    }

    deinit {
        LogicCoordinator.unsubscribe(self)
    }
    
    
    // MARK: - Stock symbol input
    
    @IBAction func symbolTextFieldValueChanged(_ sender: Any) {
        let hasText = ((sender as! UITextField).text!.count > 0)
        self.stockFetchDataButton.isEnabled = hasText
    }
    
    @IBAction func buttonStockFetchDataTapped(_ sender: Any) {
        if ((self.symbolTextField.text?.count)! > 0) {
            let symbol = self.symbolTextField.text!
            LogicCoordinator.performAction(.stockQuoteInfoRequest(symbol: symbol))
            self.view.alpha = alphaDimValue
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.buttonStockFetchDataTapped(textField)
        return true
    }

    
    // MARK: - History navigation
    
    @IBAction func buttonBackTapped(_ sender: Any) {
        LogicCoordinator.performAction(.goBackInHistory)
    }
    
    @IBAction func buttonForwardTapped(_ sender: Any) {
        LogicCoordinator.performAction(.goForwardInHistory)
    }
    
    @IBAction func buttonClearHistoryTapped(_ sender: Any) {
        LogicCoordinator.performAction(.clearHistory)
    }
    
    private func updateHistoryDisplay(state: AppState) {
        self.updateHistoryNavigationButtons(state: state)
        self.updateHistoryCountLabel(state: state)
        self.buttonClearHistory.isEnabled = state.dataModel.stocksHistory.enableClearHistory
    }
    
    private func updateHistoryNavigationButtons(state: AppState) {
        self.buttonGoBack.isEnabled = state.dataModel.stocksHistory.canGoBack
        self.buttonGoForward.isEnabled = state.dataModel.stocksHistory.canGoForward
    }
    
    private func updateHistoryCountLabel(state: AppState) {
        let historyCountLabelText: String
        if state.dataModel.stocksHistory.currentIndex != nil {
            let currentNumberInStockHistory = state.dataModel.stocksHistory.currentIndex! + 1
            let totalNumberOfStockLookups = state.dataModel.stocksHistory.history.count
            historyCountLabelText = "\(currentNumberInStockHistory) of \(totalNumberOfStockLookups)"
        } else {
            historyCountLabelText = ""
        }
        self.historyCountLabel.text = historyCountLabelText
    }
    
    
    // MARK: - Display updating
    
    private func updateDisplay(with state: AppState) {
        self.view.alpha = alphaFullValue
        self.updateStockInfoText(with: state)
        self.updateHistoryDisplay(state: state)
        self.symbolTextField.selectAll(nil)     // make it easy to type another stock symbol
    }
    
    private func updateStockInfoText(with state: AppState) {
        let stockInfo = state.dataModel.stocksHistory.currentStock
        self.stockInfoResultsTextField.text = stockInfoText(from: stockInfo)
    }
    
    private func stockInfoText(from stockInfo: DataModel.StockInfo?) -> String {
        var stockInfoText = ""
        if let stockInfo = stockInfo {
            stockInfoText.append("symbol = \(String(describing: stockInfo.symbol ?? ""))\n")
            stockInfoText.append("name = \(String(describing: stockInfo.name ?? ""))\n")
            stockInfoText.append("primaryExchange = \(String(describing: stockInfo.primaryExchange ?? ""))\n")
            stockInfoText.append("sector = \(String(describing: stockInfo.sector ?? ""))\n")
            stockInfoText.append("latestPrice = \(String(describing: stockInfo.latestPrice ?? 0))\n")
            stockInfoText.append("previousClose = \(String(describing: stockInfo.previousClose ?? 0))\n")
            stockInfoText.append("change = \(String(describing: stockInfo.change ?? 0))\n")
            stockInfoText.append("changePercent = \(String(describing: stockInfo.changePercent ?? 0))%\n")
            stockInfoText.append("week52High = \(String(describing: stockInfo.week52High ?? 0))\n")
            stockInfoText.append("week52Low = \(String(describing: stockInfo.week52Low ?? 0))\n")
            stockInfoText.append("latestVolume = \(String(describing: stockInfo.latestVolume ?? 0))\n")
        }
        return stockInfoText
    }
    

    // MARK: - AppState
    
    func update(_ state: AppState, mostRecentAction: Action) {
        switch mostRecentAction {
        case .null, .stockQuoteInfoResponse(_, _):
            updateDisplay(with: state)
            break
        case .goBackInHistory, .goForwardInHistory:
            self.updateHistoryDisplay(state: state)
            break
        default:
            break
        }
    }
}
