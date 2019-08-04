import React from 'react';
import styled from 'styled-components';

const Card = styled.div`
  max-height: 100%;
  overflow-y: auto;
  overflow-x: hidden;
  white-space: normal;
`;

const TaskListList = ({ lists }) => {
  console.log(lists);
  return(
    lists.map(list => (
      <div key={list.id} className='column' style={{height: '100%'}}>
        <Card className='ui card'>
          <div className='content'>
            <div className='header'>
              { list.attributes.title }
            </div>
            <div className='description'>
              <p>{ list.description }</p>
            </div>
          </div>
        </Card>
      </div>
    ))
  )
};

export default TaskListList
