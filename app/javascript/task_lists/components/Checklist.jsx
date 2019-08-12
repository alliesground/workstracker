import React, { useState, useEffect } from 'react';
import { Button, Header, List } from 'semantic-ui-react';
import TodoList from './TodoList';
import ToggleableTodoForm from './ToggleableTodoForm'
import { useEndpoint } from './useEndpoint';

const Checklist = (props) => {

  const [todos, fetchTodos, setTodos] = useEndpoint(() => ({
    url: props.todosLink,
    method: 'GET'
  }))

  const [todo, postNewTodo] = useEndpoint(data => ({
    url: 'todos',
    method: 'POST',
    body: JSON.stringify(data),
    headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
    }
  }));

  const payload = (todo) => (
    {
      data: {
        ...todo,
        relationships: {
          task: {
            data: {
              type: 'tasks',
              id: props.taskId
            }
          }
        }
      }
    }
  );

  useEffect(() => {

    const execute = async () => {

      if(!todos.response) fetchTodos();
      
      if(todo.completed && !todo.error) {
        setTodos(todo.response.data);
      }
    };

    execute();
  }, [todo]);

  const handleCreateFormSubmit = (todo) => {
    postNewTodo(payload(todo));
  }

  return(
    <>
      <Header>CheckList</Header>
      {
        (todos.pending && 'Loading...') ||
        (todos.completed && <List relaxed> <TodoList todos={todos.response.data} /> </List>)
      }
      <ToggleableTodoForm
        onFormSubmit={handleCreateFormSubmit}
        todo={todo}
      />
    </>
  );
}

export default Checklist;
