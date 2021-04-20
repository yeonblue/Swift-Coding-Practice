import Foundation

// 1. 모든 문자가 Unique 한지 확인
func isStringLettersUnique(input: String) -> Bool {
    var usedLetter = [Character]()
    
    for letter in input {
        if usedLetter.contains(letter) {
            return false
        }
        usedLetter.append(letter)
    }
    
    return true
}

func isStringLettersUniqueUsingSets(input: String) -> Bool {
    return Set(input).count == input.count
}

// 2. Pallndrome 판단 - reverse해도 같은 문자
func isPalindromeUsingArray(input: String) -> Bool {
    let strArr = Array(input.reversed())
    return input.lowercased().reversed() == strArr
}

// 3. 두 문자가 same characters를 갖고 있는지 확인
func isContainsSameCharacter(input1: String, input2: String) -> Bool {
    return input1.sorted() == input2.sorted()
}

// 4. 다른 한 string이 한 쪽에 포함되어 있는지 여부 확인 (contains() 미사용)

extension String {
    func isContains(_ input: String) -> Bool {
        return range(of: input, options: .caseInsensitive) != nil
    }
}

func isStringContainAnother(input: String, compStr: String) -> Bool {
    return input.range(of: compStr, options: .caseInsensitive) != nil
}

// isStringContainAnother(input: "Hello, World", compStr: "Hello") // return true

// 5. 특정 charatcter가 몇 개 포함 되어 있는지 확인
func findCharatersUsingBruteForce(input: String, findChar: Character) -> Int {
    var count = 0
    for char in input {
        if char == findChar {
            count += 1
        }
    }
    return count
}

func findCharasterUsingReduce(input: String, findChar: Character) -> Int {
    return Array(input).reduce(0, {$1 == findChar ? $0 + 1 : $0 })
}

func findCharacterUsingNSCountedSet(input: String, findChar: Character) -> Int {
    let arr = Array(input)
    let countSet = NSCountedSet(array: arr)
    
    return countSet.count(for: findChar)
}

func findCharacterUsingReplacingOccurences(input: String, findChar: Character) -> Int {
    let modifiedArr = input.replacingOccurrences(of: String(findChar), with: "")
    return input.count - modifiedArr.count
}

// 6. 중복 letter 제거 (ex: hello -> helo)
func removeDuplicateLetter(input: String) -> String {
    var used = [Character]()
    
    for char in input {
        if !used.contains(char) {
            used.append(char)
        }
    }
    
    return String(used)
}

// 7. condense whitespace
func condenseWhitespaceUsingComponents(input: String) -> String {
    let components = input.components(separatedBy: .whitespacesAndNewlines)
    return components.filter{!$0.isEmpty}.joined(separator: "")
} // "  a" -> "a"

// " a" -> " a"로 반영이 되어야 한다면
func condenseWhitespaceUsingBruteForce(input: String) -> String {
    var seenSpace = false
    var returnVal = ""
    
    for letter in input {
        if letter == " " {
            if seenSpace { continue }
            seenSpace = true
        } else {
            seenSpace = false
        }
        
        returnVal.append(letter)
    }
    return returnVal
}

func condenseWhitespaceUsingRegex(input: String) -> String {
    return input.replacingOccurrences(of: " +", // +: one or more
                                      with: " ",
                                      options: .regularExpression,
                                      range: nil)
}

// 8. 문구가 rotate 가능한지 확인 (ex: abcde, cdeab는 true) (abcde, abced는 false)
func checkStringIsRotated(input: String, rotated: String) -> Bool{
    guard input.count == rotated.count else { return false }

    let combined = input + input
    return combined.contains(rotated)
}

// 9. pangrams 확인 (모든 알파벳이 한 번 이상 포함된 문자열 - 대소문자 구분 X)
func checkPangrams(input: String) -> Bool {
    
    let set = Set(input.lowercased())
    let letters = set.filter({$0 >= "a" && $0 <= "z"})
    
    return letters.count == 26
}

// 10. 모음, 자음 수 반환
func getVowelsAndConsonantsUsingCharacterSet(input: String) -> (vowels: Int, consonants: Int) {
    var vowelCount = 0
    var consonantCount = 0
    
    let vowels = CharacterSet(charactersIn: "aeiou")
    let comsonants = CharacterSet(charactersIn: "bcdfghjklmnpqrstvwxyz")
    
    for letter in input.lowercased() {
        let stringLetter = String(letter)
        if stringLetter.rangeOfCharacter(from: vowels) != nil {
            vowelCount += 1
        } else if stringLetter.rangeOfCharacter(from: comsonants) != nil {
            consonantCount += 1
        }
    }
    
    return (vowelCount, consonantCount)
}

func getVowelsAndConsonantsUsingContain(input: String) -> (vowels: Int, consonants: Int) {
    var vowelCount = 0
    var consonantCount = 0
    
    let vowels = "aeiou"
    let comsonants = "bcdfghjklmnpqrstvwxyz"
    
    for letter in input.lowercased() {
        let stringLetter = String(letter)
        if stringLetter.contains(vowels) {
            vowelCount += 1
        } else if stringLetter.contains(comsonants) {
            consonantCount += 1
        }
    }
    
    return (vowelCount, consonantCount)
}

// 11. 4개 이상 letter가 틀리면 false 반환
func checkFourMoreLettersDifferent(first: String, second: String) -> Bool {
    guard first.count == second.count else { return false }
    
    var diffCount = 0
    let firstArr = Array(first)
    let secondArr = Array(second) // string은 subscript 불가
    
    for (idx, letter) in firstArr.enumerated() {
        if secondArr[idx] != letter {
            diffCount += 1
            
            if diffCount == 4 {
                return false
            }
        }
    }
    
    return true
}

// 12. 가장 긴 prefix 찾기 (ex: swift, swi, sw, swift! -> return sw)
func getBestPrefix(input: String) -> String{
    let parts = input.components(separatedBy: " ")
    
    guard let first = parts.first else { return "" }
    
    var currentPrefix = ""
    var bestPrefix = ""
    
    for letter in first {
        currentPrefix.append(letter)
        for word in parts {
            if !word.hasPrefix(currentPrefix) {
                return bestPrefix
            }
        }
        
        bestPrefix = currentPrefix
    }
    
    return bestPrefix
}

// 13. Run-length Encoding (ex:aabbcc -> a2b2c2, aaabaaaab -> a3b1a3b1)
func runLengthEncodingUsingBruceForce(input: String) -> String {
    var currentLetter: Character?
    var letterCount = 0
    
    var returnValue = ""
    
    for letter in input {
        if letter == currentLetter {
            letterCount += 1
        } else {
            if let current = currentLetter {
                returnValue.append("\(current)\(letterCount)")
            }
            
            currentLetter = letter
            letterCount = 1
        }
    }
    
    // 마지막 루프 반영
    if let current = currentLetter {
        returnValue.append("\(current)\(letterCount)")
    }

    return returnValue
}

// 14. String Permutations (ex: abc -> abc, acb, bac, bca, cab, cba)
func stringPermutation(input: String, current: String = "") {
    let len = input.count
    let strArr = Array(input)
    
    if(len == 0) {
        print(current)
    } else {
        for i in 0..<len {
            let left = String(strArr[0..<i])
            let right = String(strArr[i+1..<len])
            stringPermutation(input: left + right, current: current + String(strArr[i]))
        }
    }
}

// 15. String Word Reverse (ex: String Practice -> gnirtS ecitcarP)
func stringWordReverse(input: String) -> String {
    let parts = input.components(separatedBy: " ")
    let reversed = parts.map{ String($0.reversed()) }
    
    return reversed.joined(separator: " ")
}
