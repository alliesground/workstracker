import React, { useState } from 'react';
import TaskForm from './TaskForm';
import { useToggle } from './useToggle';

const ToggleableTaskForm = (props) => {

  const [isOpen, handleOpen, handleClose] = useToggle();

  const handleFormSubmit = (task) => {
    handleClose();
    props.onFormSubmit(task);
  }

  return(
    <>
      {
        isOpen ? 
        <TaskForm 
          onFormCancel={handleClose}
          onFormSubmit={handleFormSubmit}
        /> :
        <a
          onClick={handleOpen}
        >
          <i className='add icon'></i>
          Add Task
        </a>
      }
    </>
  );
}

export default ToggleableTaskForm;
