//
//  AppState.swift
//  Reduxion-iOS
//
//  Created by Ron Diamond on 9/14/16.
//  Copyright © 2016-2018 Ron Diamond.
//  Licensed per the LICENSE.txt file.
//

/**
 Single Responsibility (SRP):
 This class implements the AppState object, which contains the current state of the application.
 It can persist and recall itself as needed.
 */

import Foundation

let persistenceFileName = "AppState"

///**
// Object that encapsulates the state of the entire application, and can be persisted and recalled.
// */
struct AppState {
    // AppState is instantiated with default values (if not recalled from persistence).

    // MARK: - Data model
    var dataModel = DataModel()

    // MARK: - Persistence
    let dataModelKeyName = "dataModel"
    
//    // persist
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(self, forKey:dataModelKeyName)
//    }
    
//    // recall
//    required init(coder aDecoder: NSCoder) {
//        self.dataModel = aDecoder.decodeObject(forKey: dataModelKeyName) as? DataModel ?? DataModel()
//    }
    
    /**
     Persists the given AppState object to disk.
     */
    static func persist(_ appState: AppState) {
        print("AppState - PERSIST ***")
        if let fileURL = self.persistenceFileURL() {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(appState.dataModel)
                try data.write(to: fileURL, options: .atomic)
            } catch {
                print("Error - unable to persist file at file URL: \(fileURL)")
            }
        }
    }
    
    /**
     Recalls the AppState object from disk, and returns it.  If it doesn't exist or can't be recalled, returns a new AppState object.
     */
    static func recall() -> AppState {
        print("AppState - RECALL ***")
        var recalledAppState = AppState()
        if let fileURL = persistenceFileURL() {
            let decoder = JSONDecoder()
            let data: Data
            let newDataModel: DataModel
            do {
                data = try Data(contentsOf: fileURL)
            }
            catch {
                print("Warning: Couldn't retrieve app state from file path")
            }
            do {
                let recalledDataModel = try decoder.decode(newDataModel, from: data)
                recalledAppState.dataModel = recalledDataModel
            }
            catch {
                print("Error: Couldn't decode app state from retrieved file!")
            }
        } else {
            fatalError("Error: Couldn't get persistence file path")
        }
        
        return recalledAppState
        // needs to be stored by caller
    }
    
    /**
     Returns the string for the absolute file persistence path within the Documents directory.  If for some reason this isn't available, returns nil.
     */
    static private func persistenceFilePath() -> String? {
        let documentsDirectoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)[0]
        let fileURL = documentsDirectoryURL.appendingPathComponent(persistenceFileName)
        let filePath = fileURL.path
        
        return filePath
    }
    
    /**
     Returns the URL for the absolute file persistence path within the Documents directory.  If for some reason this isn't available, returns nil.
     */
    static private func persistenceFileURL() -> URL? {
        var url: URL? = nil
        if let path = persistenceFilePath() {
            url = URL.init(fileURLWithPath: path)
        }
        return url
    }
    
}
