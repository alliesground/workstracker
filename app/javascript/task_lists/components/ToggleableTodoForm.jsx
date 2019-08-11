import React, { useState } from 'react';
import { Button } from 'semantic-ui-react'
import { useToggle } from './useToggle';
import TodoForm from './TodoForm';

const ToggleableTodoForm = (props) => {

  const [isOpen, toggleIsOpen] = useToggle();

  const handleFormSubmit = (todo) => {
    props.onFormSubmit(todo)
  }

  return(
    <>
      {
        isOpen ?
        (
         props.todo.pending ? 'Loading...' :
         <TodoForm 
           onFormSubmit={handleFormSubmit}
           closeForm={toggleIsOpen}
         />
        ) :
        <Button
          onClick={toggleIsOpen}
        >
          Add Item
        </Button>
      }
    </>
  );
}

export default ToggleableTodoForm;
