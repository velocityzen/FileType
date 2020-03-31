import XCTest
@testable import FileType

fileprivate let packageRootPath = URL(fileURLWithPath: #file)
  .pathComponents
  .prefix(while: { $0 != "Tests" })
  .joined(separator: "/")
  .dropFirst()

fileprivate let fixturesPath = packageRootPath + "/Tests/Fixtures"

final class FileTypeTests: XCTestCase {
  func testFileType(_ fixtureName: String, type: FileTypeExtension) {
    let absolutePath = "\(fixturesPath)/\(fixtureName)"
    let url = URL(fileURLWithPath: absolutePath, isDirectory: false)
    
    guard let data = try? Data(contentsOf: url) else {
      print("Fixture not found: \(fixtureName). Look for a specific test function.")
      return
    }
        
    let fileType = getFileType(from: data)
    XCTAssertEqual(fileType?.type, type)
  }
  
  func testAll() {
    for fileType in FileType.all {
      testFileType("fixture.\(fileType.ext)", type: fileType.type)
    }
  }
  
  func testTAR() {
    testFileType("fixture.tar.Z", type: .Z)
    testFileType("fixture.tar.gz", type: .gz)
    testFileType("fixture.tar.lz", type: .lz)
    testFileType("fixture.tar.xz", type: .xz)
  }
    
  func testMPC() {
    testFileType("fixture-sv7.mpc", type: .mpc)
    testFileType("fixture-sv8.mpc", type: .mpc)
  }
    
  func testTIFF() {
    testFileType("fixture-big-endian.tif", type: .tif)
  }
  
  func testAPE() {
    testFileType("fixture-monkeysaudio.ape", type: .ape)
  }
  
  func testMIE() {
    testFileType("fixture-big-endian.mie", type: .mie)
    testFileType("fixture-little-endian.mie", type: .mie)
  }
  
  func testNEF() {
    testFileType("fixture2.nef", type: .nef)
    testFileType("fixture3.nef", type: .nef)
    testFileType("fixture4.nef", type: .nef)
  }
  
  func testDNG() {
    testFileType("fixture2.dng", type: .dng)
  }
  
  func testARW() {
    testFileType("fixture2.arw", type: .arw)
    testFileType("fixture3.arw", type: .arw)
    testFileType("fixture4.arw", type: .arw)
    testFileType("fixture5.arw", type: .arw)
  }
    
  func testOGX() {
    testFileType("fixture-unknown-ogg.ogx", type: .ogx)
  }
  
  func testWOFFOTTO() {
    testFileType("fixture-otto.woff", type: .woff)
    testFileType("fixture-otto.woff2", type: .woff2)
  }
  
  func testMOV() {
    testFileType("fixture-mjpeg.mov", type: .mov)
    testFileType("fixture-moov.mov", type: .mov)
  }
  
  func testFTYP() {
    testFileType("fixture-mif1.heic", type: .heic)
    testFileType("fixture-msf1.heic", type: .heic)
    testFileType("fixture-heic.heic", type: .heic)
    testFileType("fixture2.3gp", type: .threegp)
    testFileType("fixture-imovie.mp4", type: .mp4)
    testFileType("fixture-isom.mp4", type: .mp4)
    testFileType("fixture-isomv2.mp4", type: .mp4)
    testFileType("fixture-mp4v2.mp4", type: .mp4)
    testFileType("fixture-dash.mp4", type: .mp4)
  }
  
  func testMPEG() {
    testFileType("fixture2.mpg", type: .mpg)
    testFileType("fixture.ps.mpg", type: .mpg)
    testFileType("fixture.sub.mpg", type: .mpg)
  }
  
  func testPNG() {
    testFileType("fixture-itxt.png", type: .png)
  }
  
  func testEOT() {
    testFileType("fixture-0x20001.eot", type: .eot)
  }
  
  func testBytesCountForType() {
    XCTAssertEqual(getBytesCountForType(.ac3), 2)
    XCTAssertEqual(getBytesCountForType(.zip), 4)
    XCTAssertEqual(getBytesCountForType(.cab), 4)
  }
  
  func testBytesCountForTypes() {
    XCTAssertEqual(getBytesCountForTypes([.ac3, .zip, .cab]), 4)
  }
    
  static var allTests = [
    ("testAll", testAll),
    ("testTAR", testTAR),
    ("testMPC", testMPC),
    ("testTIFF", testTIFF),
    ("testAPE", testAPE),
    ("testMIE", testMIE),
    ("testNEF", testNEF),
    ("testDNG", testDNG),
    ("testARW", testARW),
    ("testOGX", testOGX),
    ("testWOFFOTTO", testWOFFOTTO),
    ("testMOV", testMOV),
    ("testFTYP", testFTYP),
    ("testMPEG", testMPEG),
    ("testPNG", testPNG),
    ("testEOT", testEOT),
    
    ("testBytesCountForType", testBytesCountForType),
    ("testBytesCountForTypes", testBytesCountForTypes),
  ]
}
