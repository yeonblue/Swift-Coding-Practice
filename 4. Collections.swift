import Foundation

// 35. Count the numbers
// [5, 15, 25] - count 5 -> return 3
// [55555] - count 5 -> return 5


// extension Stack where Element: Equatable -> Element가 Equatable이어야 함.
extension Collection where Iterator.Element == Int {
    
    func countNumberInArray(count: Character) -> Int {
        var total = 0
        
        for item in self {
            let str = String(item)
            
            for letter in str {
                if letter == count {
                    total += 1
                }
            }
        }
        
        return total
    }
}

// 36. Find N smallest
extension Collection where Iterator.Element: Comparable {
    
    func findNsmallest(count: Int) -> [Iterator.Element] {
        
        let sorted = self.sorted()
        return Array(sorted.prefix(count))
    }
}

// 37. 길이가 긴 것 부터 Sort
extension Collection where Iterator.Element == String {
    func sortStringByLength() -> [String] {
        return self.sorted{ $0.count > $1.count }
    }
}

// 38. 1 ~ 100 중 빠진 숫자 반환
func findMissingNumberBruteForce(input: [Int]) -> [Int] {
    let correctArr = Array(1...100)
    var missingArr = [Int]()
    
    for number in correctArr {
        if !input.contains(number) {
            missingArr.append(number)
        }
    }
    
    return missingArr
}

func findMissingNumberUsingSet(input: [Int]) -> [Int] {
    let correctArr = Array(1...100)
    let inputSet = Set(input)
    var missingArr = [Int]()
    
    for number in correctArr {
        if !inputSet.contains(number) {
            missingArr.append(number)
        }
    }
    
    return missingArr
}

func findMissingNumberUsingSetSubtract(input: [Int]) -> [Int] {
    let inputSet = Set(input)
    let testSet = Set(1...100)
    
    return Array(testSet.subtracting(inputSet)).sorted()
}

// 39. find Median []
extension Collection where Iterator.Element == Int {
    func findMedian() -> Double? {
        guard count != 0 else { return nil }
        
        let sorted = self.sorted()
        let middle = sorted.count / 2
        
        if sorted.count % 2 == 0 {
            return Double(sorted[middle] + sorted[middle - 1]) / 2
        } else {
            return Double(sorted[middle])
        }
    }
}

// 40. Linked List

class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    
    init(value: T) {
        self.value = value
    }
}

class LinkedList<T> {
    var start: LinkedListNode<T>?
    
    var centerNode: LinkedListNode<T>? {
        var slow = start
        var fast = start
        
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        return slow
    }
    
    func printNodes() {
        var currentNode = start
        while currentNode != nil {
            print(currentNode!.value, terminator: " ")
            currentNode = currentNode!.next
        }
    }
}

var list = LinkedList<Character>()
var previouseNode: LinkedListNode<Character>? = nil

for letter in "abcdefghijklmnopqrstuvwxyz" {
    let node = LinkedListNode(value: letter)
    if previouseNode != nil {
        previouseNode!.next = node
    } else {
        list.start = node
    }
    
    previouseNode = node
}
