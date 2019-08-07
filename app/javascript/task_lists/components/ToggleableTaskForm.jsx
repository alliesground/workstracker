import React, { useState } from 'react';
import TaskForm from './TaskForm';
import { useToggle } from './useToggle';

const ToggleableTaskForm = () => {

  const [isOpen, handleOpen, handleClose] = useToggle();

  return(
    <>
      {
        isOpen ? 
        <TaskForm 
          onFormCancel={handleClose}
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
