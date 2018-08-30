import Foundation

// MARK: - Data model


/**
 *  Operands inputted by the user, for doing calculations.
 */
struct Calculation {
    var operand1: Int
    var operand2: Int
    var calculationType: CalculationType
    var time: Date
}

struct Calculations {
    var history: [Calculation]
    var currentCalculation: UInt    // ?
}
