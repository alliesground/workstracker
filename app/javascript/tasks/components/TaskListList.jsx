import React from 'react';
import styled from 'styled-components';

const Card = styled.div`
  max-height: 100%;
  overflow-y: auto;
  overflow-x: hidden;
  white-space: normal;
`;

const TaskListList = ({ lists }) => (
  lists.map(list => (
    <div className='column' style={{height: '100%'}}>
      <Card className='ui card'>
        <div className='content'>
          <div className='header'>
            { list.name }
          </div>
          <div className='description'>
            <p>{ list.description }</p>
          </div>
        </div>
      </Card>
    </div>
  ))
);

export default TaskListList
