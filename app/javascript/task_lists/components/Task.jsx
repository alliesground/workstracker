import React from 'react';

const Task = ({ task, members, ...props }) => {
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

      {
        members.map(member =>
          <div> {member.attributes.name} </div>
        )
      }
    </a>
  );
};

export default Task;
