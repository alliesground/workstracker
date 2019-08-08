import React, { useState } from 'react';
import EditableTask from './EditableTask';

const Tasks = (props) => {
  return(
    props.tasks.map((task) => (
      <>
        <EditableTask task={task}/>
      </>
    ))
  );
};

export default Tasks;
