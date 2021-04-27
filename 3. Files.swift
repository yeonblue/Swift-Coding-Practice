import Foundation

// 27. 마지막 N라인 출력
func printLastLine(fileName: String, lineCnt: Int) {
    guard let input = try? String(contentsOfFile: fileName) else { return }
    var lines = input.components(separatedBy: "\n")
    
    guard lines.count > 0 else { return }
    lines.reverse()
    
    for i in 0..<min(lines.count, lineCnt) {
        print(lines[i])
    }
}

// 28. 파일이 있으면 마지막에 로그 추가
func addLogMessage(message: String, logFile: String) {
    var existLog = try? String(contentsOfFile: logFile)
    existLog?.append("\(Date()): \(message)\n")
   
    do {
        try existLog?.write(toFile: logFile, atomically: true, encoding: .utf8)
    } catch {
        print(error.localizedDescription)
    }
}

// 29. 사용자의 Documents Directory 반환
func getDocumentsDirectoryURL() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

// 30. 디렉토리에서 24시간 이내 작성된 JPEG 파일들 반환
func getJPEGsWithIn24Hour(directory: String) -> [String] {
    let fileManager = FileManager.default
    let directoryURL = URL(fileURLWithPath: directory)
    
    guard let files = try? fileManager.contentsOfDirectory(at: directoryURL,
                                                           includingPropertiesForKeys: nil) else { return [] }
    var returnJPEG = [String]()
    
    for file in files {
        if file.pathExtension == "jpg" || file.pathExtension == "jpeg" {
            guard let attributes = try? fileManager.attributesOfItem(atPath: file.path) else { continue }
            guard let createTime = attributes[.creationDate] as? Date else { continue }
            
            if createTime > Date(timeIntervalSinceNow: -60 * 60 * 24) {
                returnJPEG.append(file.lastPathComponent)
            }
        }
    }
    
    return returnJPEG
}


// 32. Word Frequency
// Hello World에서 Hello가 1번 있으면 1 리턴, It's raining에서 in은 미포함
// print( countWordFrequncyInFile(filename: "/User/Desktop/file1.txt", str: "Hello") )

func countWordFrequncyInFile(filename: String, countStr: String) -> Int {
    guard let inputString = try? String(contentsOfFile: filename) else { return 0 }
    var nonLetters = CharacterSet.letters.inverted
    nonLetters.remove("'")
    
    let allWords = inputString.components(separatedBy: nonLetters)
    let wordSet = NSCountedSet(array: allWords)
    
    return wordSet.count(for: countStr)
}

// 33. 중복 파일 이름 찾기
func findDuplicateFilename(in directory: String) -> [String] {
    let fileManager = FileManager.default
    let directoryURL = URL(fileURLWithPath: directory)
    
    guard let files = fileManager.enumerator(at: directoryURL, includingPropertiesForKeys: nil) else { return [] }
    var filenameSet = Set<String>()
    var seen = Set<String>()
    
    for case let file as URL in files {
        guard file.hasDirectoryPath == false else { continue }
        let filename = file.lastPathComponent
        
        if seen.contains(filename) {
            filenameSet.insert(filename)
        }
        
        seen.insert(filename)
    }
    
    return Array(filenameSet)
}

// 34. 실행 가능한 파일 찾기
func findExecutables(in directory: String) -> [String] {
    let fileManager = FileManager.default
    let directoryURL = URL(fileURLWithPath: directory)
    
    guard let files = try? fileManager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil) else { return [] }
    var returnVal = [String]()
    
    for file in files {
        guard file.hasDirectoryPath == false else { continue }
        if fileManager.isExecutableFile(atPath: file.path) {
            returnVal.append(file.lastPathComponent)
        }
    }
    
    return returnVal
}
