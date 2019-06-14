## API Requests

Making an HTTP request in SwiftUI is similar to React insofar as you can make the request when the component mounts, and update your state based on the content (or errors) you receive to provide visual feedback to the user. That's about where the similarities end. Making the API request is really quite different and will seem... really complex compared to writing Javascript.

In short, you make your HTTP request using `URLSession`. It accepts a URL parameter. In this example, we are fetching my profile on Github.

After fetching it, we need to either handle errors or decode our response. This will be quite different for users coming from a JS background, but it's actually relatively easy. Finally, we pass our response back to our View and update our data accordingly.

```swift
import SwiftUI
import Foundation

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

    enum APIError : Error {
        case noResponse
        case jsonDecodingError(error: Error)
        case networkError(error: Error)
    }

    func fetch (handler: @escaping (Result<Profile, Error>) -> Void) {
        guard let url = baseURL else {
            print("error...")
            return
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in

            if let error = error {
                handler(.failure(error))
            } else {

                do {
                    // attempt to decode
                    let encoder = JSONDecoder()
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
