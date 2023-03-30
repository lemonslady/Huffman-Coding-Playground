//
//  ChartView.swift
//  HuffEncoder
//
//  Created by Giulia Casucci on 30/03/23.
//


import SwiftUI
import Charts

//Chart Struct
struct ToyShape: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}

struct ChartView: View {
    
    @Binding var text: String
    @State var originalDataSize: Int = 0
    @State var compressedDataSize: Int = 0
    @State var decompressedDataSize: Int = 0
    @State var yValues: [Int]
    
    
    //Compress Function
    func compressDecompressData(str : String){
        if let originalData = str.data(using: .utf8){
            originalDataSize = originalData.count
            let huffman1 = Huffman()
            let compressedData = huffman1.compressData(data: originalData as NSData)
            compressedDataSize = compressedData.length
            let frequencyTable = huffman1.frequencyTable()
            //print(frequencyTable)
            
            let huffman2 = Huffman()
            let decompressedData = huffman2.decompressData(data: compressedData, frequencyTable: frequencyTable)
            decompressedDataSize = decompressedData.length
            
            let s2 = String(data: decompressedData as Data, encoding: .utf8)!
            print(s2)
            assert(str == s2)
            yValues = stride(from: 0, to: [originalDataSize, compressedDataSize].max()! + 1, by: 1).map { $0 }
        }
    }

   

    
    var body: some View {
        
        Chart{
            BarMark(
                    x: .value("Shape Type", "Original Data"),
                    y: .value("Total Count", originalDataSize)
                )
                BarMark(
                     x: .value("Shape Type", "Compressed"),
                     y: .value("Total Count", compressedDataSize)
                )
                BarMark(
                     x: .value("Shape Type", "Decompressed"),
                     y: .value("Total Count", decompressedDataSize)
                )
        }
        .chartYAxis{
                AxisMarks(position: .leading, values: yValues)  // << here !!
            }
         
        .onAppear{
            compressDecompressData(str: text)
        }
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(text: .constant(""), yValues: [])
    }
}
