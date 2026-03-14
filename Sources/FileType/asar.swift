import Foundation

func matchAsarHeader(_ data: Data) -> Bool {
    // Asar contains JSON header at offset 16. The root key of the JSON should be "files".
    guard data.count >= 16 else { return false }
    guard let jsonSize = data.getInt32LE(offset: 12) else {
        return false
    }

    let headerEnd = 16 + jsonSize
    guard jsonSize >= 0, data.hasBytes(in: 16..<headerEnd) else {
        return false
    }

    let jsonObject = try? JSONSerialization.jsonObject(with: data[16..<headerEnd], options: [])
    return (jsonObject as? [String: Any])?["files"] != nil
}
