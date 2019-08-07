import React from 'react';
import styled from 'styled-components';

const Card = styled.div`
  max-height: 100%;
  overflow-y: auto;
  overflow-x: hidden;
  white-space: normal;
`;

const EditableList = ({ list }) => {
  return(
    <div key={list.id} className='column' style={{height: '100%'}}>
      <Card className='ui card'>
        <div className='content'>
          <div className='header'>
            { list.attributes.title }
          </div> 
        </div>
        <div className='extra content'>
          <a>
            <i className='add icon'></i>
            Add Task
          </a>
        </div>
      </Card>
    </div>
  );
}

export default EditableList;
