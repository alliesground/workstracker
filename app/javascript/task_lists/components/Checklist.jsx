import React, { useState, useEffect } from 'react';
import { Button, Header, List } from 'semantic-ui-react';
import TodoList from './TodoList';
import ToggleableTodoForm from './ToggleableTodoForm'
import { useEndpoint } from './useEndpoint';
import WithLoading from '../hocs/WithLoading';

const TodoListWithLoading = WithLoading(TodoList);

const Checklist = (props) => {

  const [todos, fetchTodos, setTodos, updateTodos] = useEndpoint(() => ({
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

    const execute = () => {

      if(!todos.response) fetchTodos();
      
      if(todo.completed && !todo.error) {
        setTodo(todo.response.data);
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
      <List relaxed>
        <TodoListWithLoading 
          pending={todos.pending}
          completed={todos.completed}
          todos={todos.response ? todos.response.data : null}
          onUpdateTodos={updateTodos}
        />
      </List>

      <ToggleableTodoForm
        onFormSubmit={handleCreateFormSubmit}
        todo={todo}
      />
    </>
  );
}

export default Checklist;
