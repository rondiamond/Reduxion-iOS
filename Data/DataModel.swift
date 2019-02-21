import Foundation

// MARK: - Data model

struct StockInfo {
    let symbol: String
    let latestPrice: Float
    let companyName: String
    let companySector: String
}

/**
 The history of stock lookups done by the user.
 */
struct StocksHistory {
    var history: [StockInfo] = []
    var currentIndex: Int?
    var canGoBack: Bool = false
    var canGoForward: Bool = false
}
