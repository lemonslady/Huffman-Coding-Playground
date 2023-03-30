import SwiftUI

/* DocumentPicker Usage
 @State private var documentPickerIsPresented = false
 
 Button(action: {
 documentPickerIsPresented = true
 }, label: {
 Text("Click Me")
 })
 .sheet(isPresented: $documentPickerIsPresented) {
 DocumentPicker()
 }*/

struct ContentView: View {
    @State var text: String = ""
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                //Color.teal.opacity(0.9)
                //.ignoresSafeArea()
                VStack {
                    VStack(alignment: .leading){
                        Text("Then press the button to see the size in bytes.")
                            .font(.subheadline)
                            .padding(.trailing, 35)
                        
                    }
                    TextEditor(text: $text)
                        .scrollContentBackground(.hidden) // <- Hide it
                        .background(.yellow.opacity(0.3))
                        .frame(height: 100)
                        .cornerRadius(10)
                        .padding()
                    
                    
                    if !text.isEmpty {
                        NavigationLink(destination: ChartView(text: $text, yValues: [])) {
                            Text("Compress Data")
                        }
                    }
                    
                    Spacer()
                    
                }.navigationTitle("Write Something!")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





