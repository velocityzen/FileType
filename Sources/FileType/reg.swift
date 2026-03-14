import Foundation

let regedit4LFPrefix = Data("REGEDIT4\n".utf8)
let regedit4CRLFPrefix = Data("REGEDIT4\r\n".utf8)
let registryEditorV5UTF16LELFPrefix =
    "Windows Registry Editor Version 5.00\n".data(using: .utf16LittleEndian) ?? Data()
let registryEditorV5UTF16LECRLFPrefix =
    "Windows Registry Editor Version 5.00\r\n".data(using: .utf16LittleEndian) ?? Data()

func matchRegistryEditorV4(_ data: Data) -> Bool {
    data.starts(with: regedit4LFPrefix) || data.starts(with: regedit4CRLFPrefix)
}

func matchRegistryEditorV5(_ data: Data) -> Bool {
    guard data.starts(with: [0xFF, 0xFE]), data.count >= 2 else {
        return false
    }

    let registryBody = data.dropFirst(2)
    return registryBody.starts(with: registryEditorV5UTF16LELFPrefix)
        || registryBody.starts(with: registryEditorV5UTF16LECRLFPrefix)
}
