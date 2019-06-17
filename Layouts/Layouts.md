## Layouts

If you're coming from a React background, chances are you're used to doing layouts with CSS. SwiftUI is quite different in this regard. I'll be creating various layouts here to demonstrate what's possible in SwiftUI.

<img src="https://raw.githubusercontent.com/bmcmahen/react-meets-swiftui/master/Layouts/profile.png" max-width="300px" alt="Profile layout">

### React

Here's a link to a [Codesandbox](https://codesandbox.io/embed/serene-forest-1qfy1) which demonstrates this layout in React.

### Swift

```swift
struct CircleProfile : View {
    var image: Image

    var body: some View {
        image
            .resizable()
            .frame(width: 150, height: 150)
            .aspectRatio(CGSize(width: 50, height: 50), contentMode: .fill)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)

    }
}


struct ContentView : View {

    func onContact() {
        print("contact me")
    }

    var body: some View {
        VStack {
            Image("profile-background")
                .resizable()
                .aspectRatio(UIImage(named: "profile-background")!.size, contentMode: .fill)
                .edgesIgnoringSafeArea(.top)

            CircleProfile(image: Image("ben-again"))
                .offset(x: 0, y: -75)
                .padding(.bottom, -75)


            VStack(alignment: .center) {
                Text("Ben McMahen").font(.title)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                    .font(.body)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                Button(action: onContact) {
                    Text("Contact Ben")
                }.padding()
            }.padding()

        Spacer()

        }

    }
}
```
