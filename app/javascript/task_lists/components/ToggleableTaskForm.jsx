import React, { useState } from 'react';
import TaskForm from './TaskForm';
import { useToggle } from './useToggle';

const ToggleableTaskForm = (props) => {

  const [isOpen, toggleIsOpen] = useToggle();

  const handleFormSubmit = (task) => {
    toggleIsOpen();
    props.onFormSubmit(task);
  }

  return(
    <>
      {
        isOpen ? 
        <TaskForm 
          onFormCancel={toggleIsOpen}
          onFormSubmit={handleFormSubmit}
        /> :
        <a
          onClick={toggleIsOpen}
        >
          <i className='add icon'></i>
          Add Task
        </a>
      }
    </>
  );
}

export default ToggleableTaskForm;
