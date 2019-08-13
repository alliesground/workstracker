import React from 'react';
import Todo from './Todo';

const TodoList = ({ todos, ...props }) => {
  const handleSetTodos = (todo) => {
    props.onUpdateTodos(todo)
  }

  return(
    todos.map(todo => (
      <Todo 
        key={todo.id}
        todo={todo}
        onUpdateTodos={handleSetTodos}
      />
    ))
  )
};

export default TodoList; 
