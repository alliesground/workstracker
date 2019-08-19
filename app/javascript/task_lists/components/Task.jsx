import React from 'react';
import MemberList from './MemberList';

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

        <MemberList members={members} />
      </div>

    </a>
  );
};

export default Task;
