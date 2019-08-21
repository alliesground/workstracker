import React from 'react';
import MemberList from './MemberList';
import WithLoading from '../hocs/WithLoading';

const MemberListWithLoading = WithLoading(MemberList);

const MemberCount = ({ members }) => (
  <>
    <i className='users icon'></i>
    { members.length }
  </>
)

const MemberCountWithLoading = WithLoading(MemberCount);

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
      <div className='extra content'>
        <MemberCountWithLoading
          pending={members.pending}
          completed={members.completed}
          members={members.response && members.response.data}
        />
      </div>

    </a>
  );
};

export default Task;
