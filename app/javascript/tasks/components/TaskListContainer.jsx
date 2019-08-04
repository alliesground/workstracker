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
  
  const [user, postNewUser] = useEndpoint(data => ({
    url: 'users',
    method: 'POST',
    data
  }));

  useEffect(() => {

    const fetchData = async () => {
      fetchLists(); 
    };

    fetchData();
  }, []);

  const handleCreateFormSubmit = (list) => {
    setData(list);
    //postNewUser({name: 'DDP'})
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

