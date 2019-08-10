import React from 'react';

const Task = ({ task, ...props }) => {
  return(
    <a 
      className='ui card'
      onClick={props.onClick}
    >
      <div className='content'>
        <div className='description'>
          <p>{task.attributes.title}</p>
        </div>
      </div>
    </a>
  );
};

export default Task;
