import Foundation

let registryEditorV5UTF16LEPrefix =
    "Windows Registry Editor Version 5.00\r\n".data(using: .utf16LittleEndian) ?? Data()

func matchRegistryEditorV5(_ data: Data) -> Bool {
    guard data.starts(with: [0xFF, 0xFE]), data.count >= 2 else {
        return false
    }

    return data.dropFirst(2).starts(with: registryEditorV5UTF16LEPrefix)
}
