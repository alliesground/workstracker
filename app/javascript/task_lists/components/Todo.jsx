import React, { useState } from 'react';
import { Checkbox } from 'semantic-ui-react';
import { useToggle } from './useToggle';
import { List } from 'semantic-ui-react';

const Todo = ({ todo }) => {

  const [checked, toggleChecked] = useToggle();

  const handleTaskComplete = (e) => {
    toggleChecked();
  }

  return(
    <List.Item>
      <Checkbox
        label= 'Please do this task first' 
        onChange={handleTaskComplete}
        style={checked ? {textDecoration:"line-through"} : null}
      />
    </List.Item>
  );
}

export default Todo;
