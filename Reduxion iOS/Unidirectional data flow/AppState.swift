//
//  AppState.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 9/14/16.
//  Copyright © 2016-2019 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

/**
 Single Responsibility (SRP):
 This class implements the AppState object, which contains the current state of the application.
 It can persist and recall itself as needed.
 */

import Foundation

protocol AppStatePersistable {
    static func persist(_ appState: AppState)
    static func recall() -> AppState
}

/**
 Object that encapsulates the state of the entire application, and can be persisted and recalled.
 */
class AppState: NSObject, NSCoding, AppStatePersistable {
    // (Needs to inherit from NSObject, in order to implement NSCoding.)
    // AppState is instantiated with default values (if not recalled from persistence).
    // ** NOTE: For persisting data -- when adding properties, be SURE to also add them to the NSCoding methods below **

    static let persistenceFileName = "AppState"
    override init() {}
    
    // MARK: Properties
//    var currentStockInfo: StockInfo?
//    var stocksHistory = StocksHistory()
    var dataModel = DataModel()

    // MARK: Persistence key names
//    let currentStockInfoKeyName = "stockInfo"
//    let stocksHistoryKeyName = "stocksHistory"
    let dataModelKeyName = "dataModel"
    
    // MARK: - Persistence methods

    // persist
    func encode(with aCoder: NSCoder) {
//        aCoder.encode(self.stocksHistory, forKey:stocksHistoryKeyName)
        aCoder.encode(self.dataModel, forKey:dataModelKeyName)
    }
    
    // recall
    required init(coder aDecoder: NSCoder) {
//        self.stocksHistory = aDecoder.decodeObject(forKey: stocksHistoryKeyName) as? StocksHistory ?? StocksHistory()
        self.dataModel = aDecoder.decodeObject(forKey: dataModelKeyName) as? DataModel ?? DataModel()
    }
    
    /**
     Persists the given AppState object to disk.
     */
    static func persist(_ appState: AppState) {
        print("AppState - PERSIST ***")
        if let filePath = persistenceFilePath() {
            let url = URL.init(fileURLWithPath: filePath)
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: appState, requiringSecureCoding: false)
                try data.write(to: url)
            } catch {
                print("Error - data not persisted!")
            }
        }
    }

    /**
     Recalls the AppState object from disk, and returns it.  If it doesn't exist or can't be recalled, returns a new AppState object.
     */
    static func recall() -> AppState {
        print("AppState - RECALL ***")
        var recalledAppState = AppState()
        if let filePath = persistenceFilePath() {
            if let newAppState = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? AppState {
                recalledAppState = newAppState
            } else {
                print("Error: Failed to load object from filePath \(filePath)")
            }
        } else {
            print("Error: Couldn't get persistence file path")
        }
        
        return recalledAppState
        // needs to be stored by caller
    }

    /**
     Returns the absolute URL for the file persistence path within the Documents directory.  If for some reason this isn't available, returns nil.
     */
    private static func persistenceFilePath() -> String? {
        let documentsDirectoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)[0]
        let fileURL = documentsDirectoryURL.appendingPathComponent(persistenceFileName)
        let filePath = fileURL.path

        return filePath
    }
    
}
