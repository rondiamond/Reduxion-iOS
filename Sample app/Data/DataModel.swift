import Foundation

// MARK: - Data model

struct DataModel: Codable {
    /**
     The history of stock lookups done by the user.
     */
    struct StocksHistory {
        var history: [StockInfo] = []
        var currentIndex: Int?
        var currentStock: StockInfo?
        var canGoBack: Bool = false
        var canGoForward: Bool = false
    }

    /**
     Represents results for a particular stock lookup.
     */
    struct StockInfo {
        var symbol: String?
        var name: String?
        var sector: String?
        var primaryExchange: String?
        var latestPrice: Float?
        var latestUpdate: Int?   // Unix seconds
        var latestVolume: Int?
        var previousClose: Float?
        var change: Float?
        var changePercent: Float?
        var week52High: Float?
        var week52Low: Float?
    }
}
