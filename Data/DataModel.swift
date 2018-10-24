import Foundation

// MARK: - Data model

/**
 An arithmetic calculation to be done, consisting of:
 -  Two operands (floats)
 -  A type of calculation (e.g., addition, subtraction, etc.)
 -  Optionally, a result of the calculation
 */
class Calculation: NSObject, NSCoding {
    var operand1: Float
    var operand2: Float
    var calculationType: CalculationType
    var result: Float?
    
    private let keyNameOperand1         = "operand1"
    private let keyNameOperand2         = "operand2"
    private let keyNameCalculationType  = "calculationType"
    private let keyNameResult           = "result"

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.operand1,        forKey:keyNameOperand1)
        aCoder.encode(self.operand2,        forKey:keyNameOperand2)
        aCoder.encode(self.calculationType, forKey:keyNameCalculationType)
        aCoder.encode(self.result,          forKey:keyNameResult)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.operand1           = aDecoder.decodeFloat(forKey: keyNameOperand1) as Float
        self.operand2           = aDecoder.decodeFloat(forKey: keyNameOperand2) as Float
        self.calculationType    = aDecoder.decodeObject(forKey: keyNameCalculationType) as? CalculationType ?? .addition   // TODO
        self.result             = aDecoder.decodeFloat(forKey: keyNameResult) as Float
    }
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
