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

  const [lists, setLists] = useState();

  const [listsResponse, fetchLists] = useEndpoint(() => ({
    url: 'users',
    method: 'GET'
  }));
  
  const [createUserRes, postNewUser] = useEndpoint(data => ({
    url: 'users',
    method: 'POST',
    data
  }));

  useEffect(() => {

    const fetchData = async () => {
      if (!listsResponse.pending && !listsResponse.completed) {
        fetchLists();
      }

      if (listsResponse.completed && !listsResponse.error) {
        setLists(listsResponse.data)
      }
    };

    fetchData();
  }, [listsResponse]);

  const handleCreateFormSubmit = (list) => {
    setLists(lists.concat(list));
    postNewUser({name: 'DDP'})
  }

  return(
    <>
      { createUserRes.completed && console.log(createUserRes.data)  }

      <HorizontalScrollGrid
        className='ui five column grid'
        style={{display: 'block'}}
      >
        {
          (listsResponse.pending && 'Loading...') ||
          (listsResponse.completed && <TaskListList lists={lists} />)
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

