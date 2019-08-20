import React, { useState } from 'react';
import EditableTask from './EditableTask';

const EditableTasks = (props) => {
  return(
    props.tasks.map((task) => (
      props.editableTask(task)
    ))
  );
};

export default EditableTasks;
