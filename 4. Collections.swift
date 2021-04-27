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
