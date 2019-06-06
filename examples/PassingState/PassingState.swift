import SwiftUI

struct ContentView : View {
    @State var count = 0
    
    var body: some View {
        VStack(spacing: 1.0) {
            Text("Press the button below")
            ChildView(
                counter: count,
                increment: increment
            )
        }
    }
    
    func increment() {
        count += 1
    }
}


struct ChildView : View {
    var counter: Int
    var increment: () -> Void
    
    var body: some View {
        VStack {
            Text("\(counter)")
            Button(action: increment) {
                Text("Increment")
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
