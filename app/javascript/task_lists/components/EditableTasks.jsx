import React, { useState } from 'react';
import EditableTask from './EditableTask';

const EditableTasks = (props) => {
  return(
    props.tasks.map((task) => (
      <EditableTask key={task.id} task={task}/>
    ))
  );
};

export default EditableTasks;
