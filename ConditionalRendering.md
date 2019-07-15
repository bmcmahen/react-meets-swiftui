## Conditional Rendering with Optionals

This is a silly thing that confused me when first using SwiftUI. How do you render views when state is optional? In React, it's super easy:

```jsx
function Example() {
  const [profile, setProfile] = useState(null);

  return (
    <React.Fragment>
      {profile && <ProfileView profile={profile} />}
    </React.Fragment>
  );
}
```

In SwiftUI you can check if the value is `nil`. If it's not, you can render the profile and force unwrap the optional value (profile, in this case).

```swift
struct LayoutView : View {
    @State var profile: Profile?
    var body : some View {
        Group {
            if let profile = profile {
                ProfileView(profile: profile)
            }
        }
    }.onAppear(perform: fetch)

    // fetch method
}
```
