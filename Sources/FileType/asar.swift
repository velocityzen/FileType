import Foundation

func matchAsarHeader(_ data: Data) -> Bool {
    // Asar contains JSON header at offset 16. The root key of the JSON should be "files".
    guard data.count >= 16 else { return false }
    let jsonSize = data.getInt32LE(offset: 12)
    guard data.count >= jsonSize+16 else { return false }
    let jsonObject = try? JSONSerialization.jsonObject(with: data[16..<jsonSize+16], options: [])
    return (jsonObject as? [String:Any])?["files"] != nil
}
