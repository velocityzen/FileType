//
//  File.swift
//  
//
//  Created by velocityzen on 3/31/20.
//

import Foundation

internal func tarHeaderChecksumMatches(_ data: Data) -> Bool {
  if data.count < 512 { // `tar` header size, cannot compute checksum without it
    return false
  }
  
  let MASK_8TH_BIT = 0x80
  var sum = 256; // Intitalize sum, with 256 as sum of 8 spaces in checksum field
  var signedBitSum = 0; // Initialize signed bit sum

  for i in [0..<148, 156..<512].joined() { // Skip checksum field
    let byte = Int(data[i])
    sum += byte
    signedBitSum += byte & MASK_8TH_BIT; // Add signed bit to signed bit sum
  }
  
  guard let readSum = data.getIntByteString(from: 148..<154) else {
    return false
  }
    
  // Some implementations compute checksum incorrectly using signed bytes
  return (
    readSum == sum || // Checksum in header equals the sum we calculated
    readSum == (sum - (signedBitSum << 1)) // Checksum in header equals sum we calculated plus signed-to-unsigned delta
  )
}
