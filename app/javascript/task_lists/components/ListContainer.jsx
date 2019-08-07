import React, { useState } from 'react';
import styled from 'styled-components';
import ToggleableTaskForm from './ToggleableTaskForm'
import Tasks from './Tasks';

const Card = styled.div`
  max-height: 100%;
  overflow-y: auto;
  overflow-x: hidden;
  white-space: normal;
`;

const ListContainer = ({ list }) => {
  const initialState = [
    {
      id: 1,
      attributes: {title: 'First Task'}
    },
    {
      id: 2,
      attributes: {title: 'Second Task'}
    }
  ];

  const [tasks, setTask] = useState(initialState);

  const handleCreateFormSubmit = (task) => {
    setTask(tasks.concat(task));
  }

  return(
    <div className='column' style={{height: '100%'}}>
      <Card className='ui card'>
        <div className='content'>
          <div className='header'>
            { list.attributes.title }
          </div>
          { tasks && <Tasks tasks={tasks} /> }
        </div>
        <div className='extra content'>
          <ToggleableTaskForm
            onFormSubmit={handleCreateFormSubmit}
          />
        </div>
      </Card>
    </div>
  );
}

export default ListContainer;
