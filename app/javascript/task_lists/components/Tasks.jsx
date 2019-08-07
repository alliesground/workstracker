import React, { useState } from 'react';

const Tasks = (props) => {
  return(
    props.tasks.map((task) => (
      <a key={task.id} className='ui card'>
        <div className='content'>
          <div className='description'>
            <p>{task.attributes.title}</p>
          </div>
        </div>
      </a>
    ))
  );
};

export default Tasks;
