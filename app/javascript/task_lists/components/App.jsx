import React, { Component } from 'react'
import { ListsContainer } from './ListsContainer';

const App = (props) => (
  <div className='column'>
    <ListsContainer projectId={props.project_id} />
  </div>
)

export default App
