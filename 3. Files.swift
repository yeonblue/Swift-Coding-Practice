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
func getJPEGsWithIn48Hour(directory: String) -> [String] {
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
