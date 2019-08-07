import React, { useState } from 'react'

const TaskForm = (props) => {

  const [title, setTitle] = useState('');
  const [error, setError] = useState(false);
  const [err_msg, setErrMsg] = useState('');

  const handleTitleChange = (e) => {
    setTitle(e.target.value);
  }
  const handleSubmit = () => {
    const task = {
      id: 10,
      type: 'tasks',
      attributes: { title }
    }

    props.onFormSubmit(task);
  }

  return (
    <div className="ui card">
      <div className="content">
        <div className="ui form">
          <div className="field">
            <label>Title</label>
            <input 
              type='text'
              value={title}
              onChange={handleTitleChange}
            />
          </div>
          <div className='ui bottom attached buttons'>
            <button 
              className='ui basic blue button'
              onClick={handleSubmit}
            >
              Save
            </button>
            <button
              className='ui basic red button'
              onClick={props.onFormCancel}
            >
              Cancel
            </button>
          </div>
        </div>
      </div>
    </div>
  );
  
}

export default TaskForm;
