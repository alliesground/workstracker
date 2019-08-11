import React from 'react';
import Todo from './Todo';

const TodoList = ({ todos }) => {
  return(
    todos.map(todo => (
      <Todo 
        key={todo.id}
        todo={todo}
      />
    ))
  )
};

export default TodoList; 
