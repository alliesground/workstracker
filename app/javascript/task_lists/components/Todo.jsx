import React, { useState } from 'react';
import { Checkbox } from 'semantic-ui-react';
import { useToggle } from './useToggle';

const Todo = ({ todo }) => {

  const [checked, toggleChecked] = useToggle();

  const handleTaskComplete = (e) => {
    toggleChecked();
  }

  return(
    <>
      <Checkbox
        label= 'Please do this task first' 
        onChange={handleTaskComplete}
        style={checked ? {textDecoration:"line-through"} : null}
      />
    </>
  );
}

export default Todo;
