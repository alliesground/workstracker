import React, { Component } from 'react'
import { TaskListsDashboard } from './TaskListsDashboard'
import CurrentUserContext from './CurrentUserContext'
import CurrentProjectContext from './CurrentProjectContext'

const App = (props) => (

  <div className='column'>
    <CurrentUserContext.Provider value={{id: props.current_user_id}}>
      <CurrentProjectContext.Provider value={{id: props.project_id}}>
        <TaskListsDashboard
          projectId={props.project_id}
        />
      </CurrentProjectContext.Provider>
    </CurrentUserContext.Provider>
  </div>
)

export default App
