import SwiftUI
import Charts


struct ContentView: View {
    @State private var documentPickerIsPresented = false
    
    
    var body: some View {
        Button(action: {
            documentPickerIsPresented = true
        }, label: {
            Text("Click Me")
        })
        .sheet(isPresented: $documentPickerIsPresented) {
            DocumentPicker()
        }
        
    }
    
}


