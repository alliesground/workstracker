import React, { useState } from 'react';
import { Button, Form, TextArea } from 'semantic-ui-react'

const TodoForm = (props) => {
  const [title, setTitle] = useState('');

  const handleSubmit = () => {
    if(!isValid()) return;

    const todo = {
      type: 'todos',
      attributes: { title }
    }
    props.onFormSubmit(todo);
    props.closeForm;
  }

  const isValid = () => {
    return title !== ''
  }

  const handleChange = (e) => {
    setTitle(e.target.value);
  }

  return(
    <div className='ui form'>
      <div className='field'>
        <textarea 
          rows="2"
          placeholder='Add Item'
          value={title}
          onChange={handleChange}
        />
      </div>
      <div className='group inline'>
        <Button
          onClick={handleSubmit}
        >Save</Button>

        <Button
          onClick={props.closeForm}
        >Cancel</Button>
      </div>
    </div>
  );
}

export default TodoForm;
