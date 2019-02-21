import Foundation

// MARK: - Data model

struct StockInfo {
    let symbol: String
    let companyName: String
    let companySector: String
    let primaryExchange: String
    let latestPrice: Float
    let latestUpdate: Int   // Unix seconds
    let latestVolume: Int
    let previousClose: Float
    let change: Float
    let changePercent: Float
    let week52High: Float
    let week52Low: Float
}

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
