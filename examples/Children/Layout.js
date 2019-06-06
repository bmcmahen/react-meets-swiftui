import React from "react"

function Page() {
  return (
    <Layout>
      <span>This is the page content</span>
    </Layout>
  )
}

function Layout({ children }) {
  return (
    <div>
      <span>This is the layout</span>
      {children}
    </div>
  )
}
