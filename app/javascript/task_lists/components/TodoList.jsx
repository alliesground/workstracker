import React from 'react';
import Todo from './Todo';

const TodoList = ({ todos, ...props }) => {
  const handleUpdateTodo = (todo) => {
    props.onUpdateTodo(todo)
  }

  return(
    todos.map(todo => (
      <Todo 
        key={todo.id}
        todo={todo}
        onUpdateTodo={handleUpdateTodo}
      />
    ))
  )
};

export default TodoList; 
