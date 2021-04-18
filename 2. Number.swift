import Foundation

// 16. Fizz Buzz - 100 이하 수 중 3으로 나눠지면 Fizz, 5로 나눠지면 Buzz, 15로 나눠지면 Fizz Buzz
func printFizzBuzz() {
    for i in 1...100 {
        if i % 3 == 0 && i % 5 == 5 {
            print("Fizz Buzz")
        } else if i % 3 == 0 {
            print("Fizz")
        } else if i % 5 == 0 {
            print("Buzz")
        } else {
            print(i)
        }
    }
}

func printFizzBuzzFix() {
    for i in 1...100 {
        if i % 3 == 0 {
            if i % 5 == 0 {
                print("Fizz Buzz")
            } else {
                print("Fizz")
            }
        } else if i % 5 == 0 {
            print("Buzz")
        } else {
            print(i)
        }
    }
}

// 17. 범위 내 랜덤 Integer 반환
func generateRandomInteger(min: Int, max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max - min + 1))) + min
}

// 18. Recreate Pow function
func myPow(number: Int, power: Int) -> Int {
    guard number > 0, power > 0 else { return 0 }
    var returnVal = number
    
    for _ in 1..<power {
        returnVal *= number
    }
    
    return returnVal
}

func myPowUsingRecursion(number: Int, power: Int) -> Int {
    guard number > 0, power > 0 else { return 0 }
    
    if power == 1 { return number }
    return number * myPowUsingRecursion(number: number, power: power - 1)
}

// 19. Swap Two Number
//                Using XOR    Using Tuples
// a = a + b      a = a^b      (a, b) = (b, a)
// b = a - b      b = a^b
// a = a - b      a = a^b

// swap(&a, &b), swapAt(idx, idx + 1)




// 20. Check Number is Prime
func checkPrimeBruceForce(number: Int) -> Bool {
    guard number >= 2 else { return false }
    
    for i in 2..<number {
        if number % i == 0 {
            return false
        }
    }
    return true
}

func checkPrimeUsingSqrt(number: Int) -> Bool {
    guard number >= 2 else { return false }
    guard number != 2 else { return true }
    
    let max = Int(ceil(sqrt(Double(number))))
    
    for i in 2..<max {
        if number % i == 0 {
            return false
        }
    }
    return true
}

// 21. Count Binary Ones (ex: 12 = 1100 -> return 2)
func countBinaryOnes(number: Int) -> Int {
    let binaryString = String(number, radix: 2)
    let numOfOnes = binaryString.filter({$0 == "1"}).count
    return numOfOnes
}

// 21-1. 이진수 같은 개수의 1을 가진 nextHighest, Lowest 찾기 (ex: 12 = 1100 -> 17:10001, 10: 1010 )
func returnBinaryNextHighAndLow(number: Int) -> (nextHighest: Int?, nextLowest: Int?) {
    let targetBinary = String(number, radix: 2)
    let numOfTargetOnes = targetBinary.filter({$0 == "1"}).count
    
    var nextHighest: Int?
    var nextLowest: Int?
    
    for i in number + 1...Int.max {
        let currentBinary = String(i, radix: 2)
        let numOfCurrentOnes = currentBinary.filter({$0 == "1"}).count
        
        if numOfTargetOnes == numOfCurrentOnes {
            nextHighest = i
            break
        }
    }
    
    for i in (0 ..< number).reversed() {
        let currentBinary = String(i, radix: 2)
        let numOfCurrentOnes = currentBinary.filter({$0 == "1"}).count
        
        if numOfTargetOnes == numOfCurrentOnes {
            nextLowest = i
            break
        }
    }
    
    return (nextHighest, nextLowest)
}

func refactorReturnBinaryNextHighAndLow(number: Int) -> (nextHighest: Int?, nextLowest: Int?) {
    func ones(number: Int) -> Int {
        let currentBianry = String(number, radix: 2)
        return currentBianry.filter({$0 == "1"}).count
    }
    
    let targetOnes = ones(number: number)
    var nextHighest: Int?
    var nextLowest: Int?
    
    for i in number + 1...Int.max {
        if ones(number: i) == targetOnes {
            nextHighest = i
            break
        }
    }
    
    for i in (0 ..< number).reversed() {
        if ones(number: i) == targetOnes {
            nextLowest = i
            break
        }
    }
    
    return (nextHighest, nextLowest)
}
