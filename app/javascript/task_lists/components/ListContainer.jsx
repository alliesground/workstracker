import React from 'react';
import styled from 'styled-components';
import ToggleableTaskForm from './ToggleableTaskForm'

const Card = styled.div`
  max-height: 100%;
  overflow-y: auto;
  overflow-x: hidden;
  white-space: normal;
`;

const ListContainer = ({ list }) => {
  return(
    <div className='column' style={{height: '100%'}}>
      <Card className='ui card'>
        <div className='content'>
          <div className='header'>
            { list.attributes.title }
          </div>
        </div>
        <div className='extra content'>
          <ToggleableTaskForm />
        </div>
      </Card>
    </div>
  );
}

export default ListContainer;
