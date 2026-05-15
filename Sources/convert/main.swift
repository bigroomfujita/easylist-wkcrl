import Foundation
import ContentBlockerConverter

func main() {
  var input = ""
  while let line = readLine() {
    input += line + "\n"
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

  let result = ContentBlockerConverter().convertArray(
    rules: lines,
    safariVersion: SafariVersion(18),
    optimize: false,
    advancedBlocking: true,
    advancedBlockingFormat: .txt,
    maxJsonSizeBytes: nil,
    progress: nil
  )

  guard let jsonData = result.converted.data(using: String.Encoding.utf8) else {
    fputs("Error: Failed to encode JSON\n", stderr)
    exit(1)
  }

  guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData) as? [[String: Any]] else {
    fputs("Error: Invalid JSON generated\n", stderr)
    exit(1)
  }

  guard let prettyJSON = try? JSONSerialization.data(
    withJSONObject: jsonObject,
    options: [.prettyPrinted, .sortedKeys]
  ) else {
    fputs("Error: Failed to format JSON\n", stderr)
    exit(1)
  }

  guard let output = String(data: prettyJSON, encoding: String.Encoding.utf8) else {
    fputs("Error: Failed to convert JSON to string\n", stderr)
    exit(1)
  }

  print(output)
}

main()
