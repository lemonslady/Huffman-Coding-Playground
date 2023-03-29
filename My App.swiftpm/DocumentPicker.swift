//
//  DocumentPicker.swift
//  HuffEncoder
//
//  Created by Giulia Casucci on 27/03/23.
//

///UIKit has a class called UIView, which is the parent class of all views (abels, buttons, text fields...)
///UIKit has a class called UIViewController, which is designed to hold all the code to bring views to life.
///UIKit uses a design pattern called delegation to decide where work happens.

import UniformTypeIdentifiers
import SwiftUI
struct DocumentPicker: UIViewControllerRepresentable {
    
    ///UIViewControllerRepresentable protocol, to conform two functions need to be implemented:
    ///makeUIViewController(), which is responsible for creating the initial view controller
    ///updateUIViewController(), which is designed to let us update the view controller when some SwiftUI state changes
    
    func makeCoordinator() -> DocumentPickerCoordinator {
        return DocumentPickerCoordinator()
    }
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> some UIDocumentPickerViewController {
        let contentTypes: [UTType] = [.plainText]
        
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: contentTypes, asCopy: false)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<DocumentPicker>) { }
    
}


////SwiftUI’s coordinators are designed to act as delegates for UIKit view controllers.
///Delegates are objects that respond to events that occur elsewhere.
class DocumentPickerCoordinator: NSObject, UIDocumentPickerDelegate {
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let shouldStopAccessing = url.startAccessingSecurityScopedResource()
        
        do {
            /// I have the URL of the .txt
            print("-- URL Object: \(url)")
            
            /// Reading the content of the file
            let s1 = try String(contentsOf: url, encoding: .utf8)
            
            if let originalData = s1.data(using: .utf8) {
                print("-- Size of the original data: \(originalData.count)")
                
                let huffman1 = Huffman()
                let compressedData = huffman1.compressData(data: originalData as NSData)
                print(compressedData.length)
                
                ///This is the new compressed file. We'll write to it and read from it
                let file = "fileCompressedNew"
                
                if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let fileURL = dir.appendingPathComponent(file)
                    print(fileURL)
                    do {
                        try compressedData.write(to: fileURL)
                    }
                    catch {/* error handling here */}
                }
                
                
                
                let frequencyTable = huffman1.frequencyTable()
                print(frequencyTable)
                 
                 let huffman2 = Huffman()
                 let decompressedData = huffman2.decompressData(data: compressedData, frequencyTable: frequencyTable)
                 print(decompressedData.length)
                 
                 let s2 = String(data: decompressedData as Data, encoding: .utf8)!
                 print(s2)
                 assert(s1 == s2)
                 
            }
            
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
    
    
}
