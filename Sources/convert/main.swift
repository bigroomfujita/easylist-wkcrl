import Foundation
import ContentBlockerConverter

let minimumExpectedRules = 1000

func main() {
  let inputData = FileHandle.standardInput.readDataToEndOfFile()
  guard let input = String(data: inputData, encoding: String.Encoding.utf8) else {
    fputs("Error: Failed to decode stdin as UTF-8\n", stderr)
    exit(1)
  }

  let lines = input
    .split(separator: "\n", omittingEmptySubsequences: true)
    .map(String.init)
    .filter { line in
      let trimmed = line.trimmingCharacters(in: .whitespaces)
      return !trimmed.isEmpty
        && !trimmed.starts(with: "!")
        && !trimmed.starts(with: "[")
    }

  guard !lines.isEmpty else {
    fputs("Error: No valid filter rules found\n", stderr)
    exit(1)
  }

  fputs("Input: \(lines.count) filter rules\n", stderr)

  let result = ContentBlockerConverter().convertArray(
    rules: lines,
    safariVersion: SafariVersion(18),
    optimize: false,
    advancedBlocking: true,
    advancedBlockingFormat: .txt,
    maxJsonSizeBytes: nil,
    progress: nil
  )

  fputs("Converted: \(result.convertedCount) / total: \(result.totalConvertedCount)\n", stderr)
  fputs("Errors: \(result.errorsCount), OverLimit: \(result.overLimit)\n", stderr)
  if !result.message.isEmpty {
    fputs("Message: \(result.message)\n", stderr)
  }

  if result.overLimit {
    fputs("Error: Ruleset exceeded Safari content blocker limit\n", stderr)
    exit(1)
  }

  if result.convertedCount < minimumExpectedRules {
    fputs("Error: Only \(result.convertedCount) rules converted (minimum: \(minimumExpectedRules))\n", stderr)
    exit(1)
  }

  print(result.converted)
}

main()
