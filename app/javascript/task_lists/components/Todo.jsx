import React, { useState, useEffect } from 'react';
import { Checkbox } from 'semantic-ui-react';
import { List } from 'semantic-ui-react';
import { useEndpoint } from './useEndpoint';


const Todo = ({ todo }) => { 

  const [checked, setChecked] = useState(false);
  const [checkListUpdated, setCheckListUpdated] = useState(false);

  const [updatedTodo, updateTodo] = useEndpoint(data => ({
    url: `todos/${todo.id}`,
    method: 'PUT',
    body: JSON.stringify(data),
    headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
    }
  }));

  const handleTaskComplete = () => {
    setCheckListUpdated(true)
    setChecked(!checked);
  }

  useEffect(() => {
    if(checkListUpdated) {
      updateTodo({
        data: {
          id: todo.id,
          type: 'todos',
          attributes: {
            completed: checked
          }
        }
      });
    } else {
      setChecked(todo.attributes.completed)
    }
  },[checked]);

  return(
    <List.Item>
      <Checkbox
        label= {todo.attributes.title} 
        onChange={handleTaskComplete}
        style={checked ? {textDecoration:"line-through"} : null}
        checked={checked}
      />
    </List.Item>
  );
}

export default Todo;
