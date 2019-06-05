import React, { useContext } from "react"

const Session = React.createContext({ name: "" })

export function ContextProvider() {
  return (
    <Session.Provider value={{ name: "Bento" }}>
      <Parent />
    </Session.Provider>
  )
}

export function Parent() {
  return <Child />
}

export function Child() {
  const session = useContext(Session)

  return <span>Hello {session.name}</span>
}
