# easylist-wkcrl

Converts [EasyList](https://easylist.to/) to [WebKit Content Blocker](https://webkit.org/blog/3476/content-blockers-first-look/)
JSON format for use with `WKContentRuleList` on iOS/macOS.

The compiled JSON is published via [GitHub Releases](https://github.com/bigroomfujita/easylist-wkcrl/releases).

## How it works

1. GitHub Actions downloads `easylist.txt` from easylist.to on the 1st of each month
2. [AdguardTeam/SafariConverterLib](https://github.com/AdguardTeam/SafariConverterLib) compiles it to Safari Content Blocker JSON
3. The resulting JSON is signed, checksummed, and published as a GitHub Release

## License

### Converter source code (Swift)

The Swift source code in this repository is licensed under the
[GNU General Public License v3.0 or later](LICENSE).

### Released JSON files (`easylist-content-rules.json`)

The compiled JSON files published in GitHub Releases are **derivative works of EasyList**
and are distributed under the same license as EasyList:

**[Creative Commons Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)](https://creativecommons.org/licenses/by-sa/3.0/) or later**

Attribution:
- **Work**: EasyList
- **Authors**: The EasyList authors
- **Source**: https://easylist.to/
- **License**: https://easylist.to/pages/licence.html
