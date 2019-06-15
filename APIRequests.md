## API Requests

Making an HTTP request in SwiftUI is similar to React insofar as you can make the request when the component mounts, and update your state based on the content (or errors) you receive to provide visual feedback to the user. That's about where the similarities end. Making the API request is really quite different and will seem... really, really complex compared to writing Javascript.

### React

[Codesandbox](https://codesandbox.io/embed/gifted-moon-eo8g8)

```jsx
function ContentView() {
  const [profile, setProfile] = React.useState(null);
  const [loading, setLoading] = React.useState(true);
  const [error, setError] = React.useState(false);

  const fetch = React.useCallback(() => {
    setLoading(true);
    setError(false);

    // make our api request
    window
      .fetch("https://api.github.com/users/bmcmahen")
      .then(res => res.json())
      .then(json => {
        setProfile(json);
      })
      .catch(err => {
        setError(true);
      });

    setLoading(false);
  }, []);

  React.useEffect(() => {
    fetch();
  }, [fetch]);

  return (
    <div>
      {loading && <div>Loading</div>}
      {error && <div>Oh no!</div>}
      {profile && <div>Render the profile here...</div>}
    </div>
  );
}
```

### Swift

In short, you make your HTTP request using `URLSession`. It accepts a URL parameter. In this example, we are fetching my profile on Github.

After fetching it, we need to either handle errors or decode our response. This will be quite different for users coming from a JS background, but it's actually relatively easy. Finally, we pass our response back to our View and update our data accordingly.

```swift
import SwiftUI
import Foundation

// this will be our Profile model. It uses the Decodable protocol so that
// we can convert our JSON response to our swift struct.
struct Profile : Decodable {
    let id: Int
    let url: URL
    let avatarUrl: URL
    let location: String
    let bio: String
    let followers: Int
    let following: Int
    let blog: URL
}


struct API {
    let baseURL = URL(string: "https://api.github.com/users/bmcmahen")

    // create our fetch function with a responder handler callback
    func fetch (handler: @escaping (Result<Profile, Error>) -> Void) {

        // ensure that our url is unpacked
        guard let url = baseURL else {
            print("error...")
            return
        }

        // use URLSession to fetch our data
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in

            // handle network errors
            if let error = error {
                handler(.failure(error))
            } else {

                // attempt to decode our JSON
                do {
                    // attempt to decode
                    let encoder = JSONDecoder()

                    // convert any snake_case to camelCase
                    encoder.keyDecodingStrategy = .convertFromSnakeCase
                    let data = data ?? Data()
                    let profile = try encoder.decode(Profile.self, from: data)
                    handler(.success(profile))
                } catch {
                    handler(.failure(error))
                }

            }

        }

        task.resume()
    }
}


struct ProfileView : View {
    var profile: Profile

    var body : some View {
      Text("profile: \(profile.bio)")
    }
}

struct ContentView : View {
    @State var loading = false
    @State var error = false
    @State var profile: Profile?

    var body: some View {
        VStack {
            if (loading) {
                Text("Loading...")
            }
            if (error) {
                Text("Error. Doh!")
            }
            if (profile != nil) {
              ProfileView(profile: profile!)
            }
        }.onAppear(perform: fetch)
    }

    // make our fetch request on mount
    func fetch () {

        loading = true
        error = false

        API().fetch() { result in

            self.loading = false

            // handle success or failure
            switch result {
            case .success(let profile):
                print("Success! \(profile)")
                self.profile = profile
            case .failure: self.error = true
            }
        }
    }


}
```
