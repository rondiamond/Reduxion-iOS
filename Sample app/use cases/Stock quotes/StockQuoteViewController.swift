//
//  ViewController.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 9/18/18.
//  Copyright © Ron Diamond.
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.symbolTextField.becomeFirstResponder()
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
            LogicCoordinator.performAction(.stockQuoteRequest(symbol: symbol))
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
        self.historyCountLabel.text = state.dataModel.stocksHistory.historyCountDescription
        self.buttonClearHistory.isEnabled = state.dataModel.stocksHistory.enableClearHistory
    }
    
    private func updateHistoryNavigationButtons(state: AppState) {
        self.buttonGoBack.isEnabled = state.dataModel.stocksHistory.canGoBack
        self.buttonGoForward.isEnabled = state.dataModel.stocksHistory.canGoForward
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
            stockInfoText.append("exchangeName = \(String(describing: stockInfo.exchangeName ?? ""))\n")
            stockInfoText.append("latestPrice = \(String(describing: stockInfo.latestPrice ?? ""))\n")
            stockInfoText.append("latestVolume = \(String(describing: stockInfo.latestVolume ?? ""))\n")
            stockInfoText.append("marketCap = \(String(describing: stockInfo.marketCap ?? ""))\n")

            if let latestUpdateTime = stockInfo.latestUpdateTime {
                let latestUpdateTimeDouble = Double(latestUpdateTime)
                let latestUpdateDate = Date(timeIntervalSince1970: latestUpdateTimeDouble)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                let formattedDateTime = dateFormatter.string(from: latestUpdateDate)
                stockInfoText.append("latestUpdateTime = \(String(describing: formattedDateTime))")
            }
        }
        return stockInfoText
    }
    

    // MARK: - AppState
    
    func update(_ state: AppState, mostRecentAction: Action) {
        switch mostRecentAction {
        case .null, .stockQuoteResponse(_, _), .goBackInHistory, .goForwardInHistory, .clearHistory:
            updateDisplay(with: state)
            break
        default:
            break
        }
    }
}
