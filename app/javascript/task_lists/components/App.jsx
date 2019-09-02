import React, { Component } from 'react'
import { TaskListsDashboard } from './TaskListsDashboard'

const App = (props) => (
  <div className='column'>
    <TaskListsDashboard 
      projectId={props.project_id} 
      current_user_id={props.current_user_id}
    />
  </div>
)

export default App
