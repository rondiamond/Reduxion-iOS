import Foundation

// MARK: - Data model

/**
 * A
 Operands inputted by the user, for doing calculations.
 */

/**
 An arithmetic calculation to be done, consisting of:
 -  Two operands (floats)
 -  A type of calculation (e.g., addition, subtraction, etc.)
 -  A timestamp of when the calculation was requested
 */
struct Calculation {
    var result: Float = 0
    /*
     // future use
     var operand1: Float = 0
     var operand2: Float = 0
     var calculationType: CalculationType = .addition
     */
}
