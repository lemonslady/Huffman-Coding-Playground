//
//  NSData.swift
//  HuffEncoder
//
//  Created by Giulia Casucci on 29/03/23.
//

import Foundation

///*******************
///Data and NSData are types used to interact with raw binary data.
///The smallest piece of data that NSData understands is the byte, and because we're dealing with bits we need to translate between the two.
///*******************

public class BitWriter {
    public var data = NSMutableData()
    var outByte: UInt8 = 0
    var outCount = 0
    
    public func writeBit(bit: Bool) {
        if outCount == 8 {
            data.append(&outByte, length: 1)
            outCount = 0
        }
        outByte = (outByte << 1) | (bit ? 1 : 0)
        outCount += 1
    }///Use writeBit() to add a new byte into the outByte variable. Once you've written 8 bits, outByte gets added to the NSData object.
    
    
    public func flush() {
        if outCount > 0 {
            if outCount < 8 {
                let diff = UInt8(8 - outCount)
                outByte <<= diff
            }///moves the specified amount of bits to the left and assigns the result to the variable.
            data.append(&outByte, length: 1)
        }
    }///The method flush() adds a few 0-bits to make sure that a full byte is written.
    
}



///*******************
///Reads one whole byte from the NSData object and put it in inByte. Then readBit() returns the individual bits from that byte. Once readBit() has been called 8 times, we read the next byte from the NSData.
///*******************

public class BitReader {
    var ptr: UnsafePointer<UInt8>
    var inByte: UInt8 = 0
    var inCount = 8
    public init(data: NSData) {
        ptr = data.bytes.assumingMemoryBound(to: UInt8.self)
    }
    
    
    ///readbit() is called x 8 times to put the bits in inByte. Then reads the next byte from NSData.
    ///readBit() returns the individual bits from that byte.
    public func readBit() -> Bool {
        if inCount == 8 {
            inByte = ptr.pointee    ///load the next byte
            inCount = 0
            ptr = ptr.successor()
        }
        
        let bit = inByte & 0x80  ///read the next bit
        inByte <<= 1
        inCount += 1
        return bit == 0 ? false : true
    }
}
