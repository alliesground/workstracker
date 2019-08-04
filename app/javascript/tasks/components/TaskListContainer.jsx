import React, { useState, useEffect, useLayoutEffect } from 'react';
import TaskListList from './TaskListList';
import ToggleableListForm from './ToggleableListForm';
import styled from 'styled-components';
import { client } from '../../Client';
import { useEndpoint } from './useEndpoint';

const HorizontalScrollGrid = styled.div`
  overflow-x: auto;
  overflow-y: hidden;
  white-space: nowrap;
  height: calc(100vh - 144px);
`;

export const TaskListContainer = () => {

  const [lists, fetchLists, setData] = useEndpoint(() => ({
    url: 'lists',
    method: 'GET'
  }));
  
  const [user, postNewList] = useEndpoint(data => ({
    url: 'lists',
    method: 'POST',
    body: JSON.stringify(data),
    headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
    }
  }));

  useEffect(() => {

    const fetchData = async () => {
      fetchLists(); 
    };

    fetchData();
  }, []);

  const handleCreateFormSubmit = (payload) => {
    setData(payload.data);
    postNewList(payload);
  }

  return(
    <>
      {
        (user.completed && console.log(user.data))
      }

      <HorizontalScrollGrid
        className='ui five column grid'
        style={{display: 'block'}}
      >
        {
          (lists.pending && 'Loading...') ||
    
          (lists.completed && <TaskListList lists={lists.data} />)
        }

        <div className="column" style={{height: '100%'}}>
          <ToggleableListForm
            onFormSubmit={handleCreateFormSubmit}
          />
        </div>
      </HorizontalScrollGrid>
    </>
  );
}

