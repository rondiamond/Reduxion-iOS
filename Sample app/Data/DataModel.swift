import Foundation

// MARK: - Data model

/**
 Single Responsibility (SRP):
 This struct implements the application's data model.
 */

struct DataModel: Codable {
    /**
     The actual data.
     */
    var stocksHistory = StocksHistory()
    
    /**
     The history of stock lookups done by the user.
     */
    struct StocksHistory: Codable {
        var history: [StockInfo] = []
        var currentIndex: Int?
        var currentStock: StockInfo?
        var canGoBack: Bool = false
        var canGoForward: Bool = false
        var enableHistoryClear: Bool = false
        var historyCountDescription: String = ""   // e.g., "2 of 3"
    }

    /**
     Represents results for a particular stock lookup.
     */
    struct StockInfo: Codable {
        var symbol: String?
        var name: String?
        var latestPrice: String?
        var latestUpdateTime: Int?  // Unix seconds
        var priceHigh: Float?
        var priceLow: Float?
        var latestVolume: Int?
        var exchangeName: String?
        var instrumentType: String?
        var firstTradeDate: Int?
    }
}
