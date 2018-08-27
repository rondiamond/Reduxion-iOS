import Foundation

// MARK: - Services type

enum LogicCoordinatorServicesType {
    case mock
    case real
}

/**
 Selects the type of services injected into the logic coordinator, for the running application (vs. the unit tests)
 */
let currentLogicCoordinatorServicesType: LogicCoordinatorServicesType = .real
