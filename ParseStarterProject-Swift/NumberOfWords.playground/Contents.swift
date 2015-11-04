//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
func wordCount(string: String) -> [String: Int] {
    
    let words = string.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    var wordDictionary = [String: Int]()
    
    for word in words {
        if let count = wordDictionary[word] {
            wordDictionary[word] = count + 1
        } else {
            wordDictionary[word] = 1
        }
    }
    print(wordDictionary.count)

    return wordDictionary
}

wordCount(str)
