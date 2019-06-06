//
//  Context.swift
//  SwiftUIExperiments
//
//  Created by Ben McMahen on 2019-06-05.
//  Copyright © 2019 Ben McMahen. All rights reserved.
//

import SwiftUI
import Combine

final class Session: BindableObject {
    let didChange = PassthroughSubject<Session, Never>()
    
    var name: String {
        didSet { didChange.send(self) }
    }
    
    init(name: String) {
        self.name = name
    }
}


struct ContextProvider : View {
    var body: some View {
        Parent().environmentObject(Session(name: "Bento"))
    }
}

struct Parent : View {
    var body: some View {
        Child()
    }
}

struct Child : View {
    
    @EnvironmentObject var session: Session
    
    var body: some View {
        Text("Hello \(session.name)")
    }
}

#if DEBUG
struct ContextProvider_Previews : PreviewProvider {
    static var previews: some View {
        ContextProvider()
    }
}
#endif
