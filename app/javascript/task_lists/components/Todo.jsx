import React, { useState, useEffect } from 'react';
import { Checkbox } from 'semantic-ui-react';
import { List, Label } from 'semantic-ui-react';
import { useEndpoint } from './useEndpoint';
import EditableLabel from './EditableLabel';


const Todo = ({ todo, onUpdateTodo }) => { 

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

  const handleTaskComplete = (e) => {
    setCheckListUpdated(true)
    setChecked(!checked);
  }

  const handleEditTitle = (title) => {
    const attributes = {...todo.attributes, title}
    onUpdateTodo({...todo, attributes});

    updateTodo({
      data: {
        id: todo.id,
        type: 'todos',
        attributes: { title }
      }
    });
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
      <div className="ui form">
        <div className="inline fields">
          <div className="field">
            <div className="ui checkbox">
              <input 
                type="checkbox" 
                tabIndex="0" 
                className="hidden" 
                onChange={handleTaskComplete}
                checked={checked}
              />
              <label
                onClick={handleTaskComplete}
              ></label>
            </div>
          </div>
          
          <div className="sixteen wide field">
            <EditableLabel
              title={todo.attributes.title}
              onSubmit={handleEditTitle}
              strikeThrough={checked}
            />
          </div>
        </div>
      </div>
    </List.Item>
  );
}

export default Todo;
