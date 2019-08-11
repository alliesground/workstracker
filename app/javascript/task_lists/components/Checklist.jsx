import React, { useState } from 'react';
import { Button, Header, List } from 'semantic-ui-react';
import TodoList from './TodoList';
import ToggleableTodoForm from './ToggleableTodoForm'

const Checklist = () => {

  const initialTodos = [
    {
      id: 1,
      attributes: {
        title: 'First Task'
      }
    },
    {
      id: 2,
      attributes: {
        title: 'Second Task'
      }
    },
    {
      id: 3,
      attributes: {
        title: 'Third Task'
      }
    }
  ];

  const [todos, setTodos] = useState(initialTodos)

  const handleCreateFormSubmit = (todo) => {
    const newTodos = todos.concat(todo);
    setTodos(newTodos);
  }

  return(
    <>
      <Header>CheckList</Header>
      <List relaxed>
        <TodoList 
          todos={todos}
        />
      </List>
      <ToggleableTodoForm
        onFormSubmit={handleCreateFormSubmit}
      />
    </>
  );
}

export default Checklist;
