import Foundation

// MARK: - Data model

/**
 An arithmetic calculation to be done, consisting of:
 -  Two operands (floats)
 -  A type of calculation (e.g., addition, subtraction, etc.)
 -  A timestamp of when the calculation was requested
 */
struct Calculation {
    var operand1: Float
    var operand2: Float
    var calculationType: CalculationType
    var result: Float?
}

/**
 The history of Calculations done by the user.
 */
struct Calculations {
    var history: [Calculation] = []
    var currentIndex: Int?
    var canGoBack: Bool = false
    var canGoForward: Bool = false
}
