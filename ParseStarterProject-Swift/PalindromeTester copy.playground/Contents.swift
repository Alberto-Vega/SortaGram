//: Playground - noun: a place where people can play

import UIKit

func palindromeTester(stringToCheck: String) {
    
    var lowerCaseString = stringToCheck.lowercaseString
    var stringWithoutSpaces = ""
    var reversedString = ""
    
    for char in lowerCaseString.unicodeScalars {
        if "\(char)" != " " {
            reversedString = "\(char)" + reversedString
            stringWithoutSpaces = stringWithoutSpaces + "\(char)"
        }
    }
    
    if stringWithoutSpaces == reversedString {
        print("This string is a Palindrome")
    } else {
        print("This string it is not a Palindrome")
    }
    print(stringWithoutSpaces == reversedString)
}

var tacoCat = "Taco cat"
var panama = "a man a plan a canal panama"

palindromeTester(panama)

palindromeTester(tacoCat)




