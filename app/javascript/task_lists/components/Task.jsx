import React, { useEffect, useState } from 'react';
import WithLoading from '../hocs/WithLoading';

const Title = ({ task }) => (
  <p>{task.attributes.title}</p>
)

const TitleWithLoading = WithLoading(Title)

const Task = ({ task, members, ...props }) => {

  const [onClickProp, setOnClickProp] = useState({onClick: null});

  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    console.log('MemberChanged ', members)
    if (members && props.filteredProjectMembers) {
      setOnClickProp({
        onClick: props.onClick
      });
      setIsLoading(false);
    }
  }, [members, props.filteredProjectMembers, props.onClick]);

  return(
    <a 
      className='ui card'
      {...onClickProp}
    >
      <div className='content'>
        <div className='description'>
          <TitleWithLoading 
            pending={isLoading}
            completed={!isLoading}
            task={task}
          />
        </div>
      </div>
      <div className='extra content'>
        <i className='users icon'></i>
        { members && members.length }
      </div>

    </a>
  );
};

export default Task;
