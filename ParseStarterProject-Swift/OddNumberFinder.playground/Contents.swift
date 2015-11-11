//: Playground - noun: a place where people can play

import UIKit


func findOddNumbers(listOfNumbers:[Int]) {
    
    var oddNumbersList = [Int]()
    
for number in listOfNumbers {
    if number % 2 != 0 {
        oddNumbersList.append(number)
    }
}
    print(oddNumbersList)
}



var numbers = [1,2,3,4,5,6,7,8,9,10]

findOddNumbers(numbers)