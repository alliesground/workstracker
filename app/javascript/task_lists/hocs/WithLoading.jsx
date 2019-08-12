import React from 'react'

const WithLoading = (Component) => (
  ({pending, completed, ...props}) => 
    (pending && 'Loading...') ||
    (completed && <Component {...props} />)
)

export default WithLoading;
