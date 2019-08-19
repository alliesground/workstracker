import React from 'react';
import MemberList from './MemberList';
import WithLoading from '../hocs/WithLoading';

const MemberListWithLoading = WithLoading(MemberList);

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

        <MemberListWithLoading 
          pending={members.pending}
          completed={members.completed}
          members={members}
        />
      </div>

    </a>
  );
};

export default Task;
