import React from "react"

export function ContentView() {
  const [count, setCount] = useState(0)

  function increment() {
    setCount(count + 1)
  }

  return (
    <div>
      <div>Press the button below</div>
      <ChildView count={count} increment={increment} />
    </div>
  )
}

export function ChildView({ counter, increment }) {
  return (
    <div>
      <div>{counter}</div>
      <button onClick={increment}>Increment</button>
    </div>
  )
}
