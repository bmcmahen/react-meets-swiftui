import SwiftUI

struct Page : View {
    var body: some View {
        Layout() {
            Text("This is the page content")
        }
    }
}

struct Layout : View {
    
    var content: () -> Text
    
    var body: some View {
        VStack {
            Text("This is the layout")
            content()
        }
    }
}

#if DEBUG
struct Page_Previews : PreviewProvider {
    static var previews: some View {
        Page()
    }
}
#endif
