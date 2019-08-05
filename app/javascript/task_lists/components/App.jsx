import React, { Component } from 'react'
import TaskListList from './TaskListList';
import { TaskListContainer } from './TaskListContainer';

const App = (props) => (
  <div className='column'>
    <TaskListContainer projectId={props.project_id} />
  </div>
)

export default App
