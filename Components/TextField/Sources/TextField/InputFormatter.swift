import Foundation

public class InputFormatter: NSObject {
    public static func formatStringToMask(text: String, format: String, minNumber: Int, max: Int) -> String {
        guard text.isEmpty == false else { return text }

        var str = ""
        let checkText = text.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
        let checkFormat = format.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
        for i in 0..<min(checkText.count, checkFormat.count) {
            let index = checkText.index(checkText.startIndex, offsetBy: i)
            if checkFormat[index] == "9" && checkText[index].isNumber || checkFormat[index] == "*" && !checkText[index].containsSpecialCharacters() {
                str += String(checkText[index])
            }
        }
        
        var formattedString = ""
        var j = 0
        
        for i in 0..<str.count {
            let strIndex = str.index(str.startIndex, offsetBy: i)
            let formatIndex = format.index(format.startIndex, offsetBy: j)

            if format[formatIndex] == " " || format[formatIndex] == "-" {
                formattedString += String(format[formatIndex])
                j += 1
            }
            formattedString += String(str[strIndex])
            j += 1
        }

        return formattedString
    }
    
    public static func isStringValidToRange(text: String, min: Int, max: Int) -> Bool {
        let textWithNoSpaces = text.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
        return textWithNoSpaces.count >= min && textWithNoSpaces.count <= max
    }
    
    public static func formatNameString(text: String) -> String {
        guard text.isEmpty == false else { return text }
        return text.onlyLetters.firstUppercased
    }
    
    public static func formatAmountString(text: String, prefix: String? = nil, postfix: String? = nil) -> String {
        guard text.isEmpty == false else { return text }
        guard text != "." else { return "" }
        var formattedText = text
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: prefix ?? "", with: "")
            .replacingOccurrences(of: postfix ?? "", with: "")
        
        if formattedText.contains(".") {
            // case: 123.. - Prevent multiple dots in text
            let arraysDevidedByDot = formattedText.components(separatedBy: ".")
            if arraysDevidedByDot.count > 1 {
                formattedText = arraysDevidedByDot[0] + "." + arraysDevidedByDot.dropFirst().joined()
            }
            // case: 123.2323232 - Allow only 2 digits after dot
            formattedText = arraysDevidedByDot[0] + "." + arraysDevidedByDot.dropFirst().joined().prefix(2)
        }
        // case: 0232.03 - Prevent digits after zero if it's the first char
        if formattedText.first == "0" && formattedText.dropFirst().first != "." {
            formattedText = "0"
        }
        formattedText = "\(prefix ?? "")\(formattedText)\(postfix ?? "")"
        return formattedText
    }
}
