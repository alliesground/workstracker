import React, { useState, useEffect, useLayoutEffect } from 'react';
import TaskListList from './TaskListList';
import ToggleableListForm from './ToggleableListForm';
import styled from 'styled-components';
import { useEndpoint } from './useEndpoint';

const HorizontalScrollGrid = styled.div`
  overflow-x: auto;
  overflow-y: hidden;
  white-space: nowrap;
  height: calc(100vh - 144px);
`;

export const TaskListContainer = (props) => {

  const [projectLists, fetchProjectLists] = useEndpoint(() => ({
    url: `projects/${props.projectId}/relationships/lists`,
    method: 'GET'
  }));

  const [lists, fetchLists, setLists] = useEndpoint(() => ({
    url: `${projectLists.response.links.related}`,
    method: 'GET'
  }));
  
  const [list, postNewList] = useEndpoint(data => ({
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
      if(!projectLists.pending && !projectLists.completed) {
        fetchProjectLists(); 
      }

      if(projectLists.completed && !projectLists.error) {
        if(!lists.response) fetchLists();
      }

      if(list.completed && !list.error) {
        setLists(list.response.data);
      }
    };

    fetchData();
  }, [projectLists, list]);

  const handleCreateFormSubmit = (list) => {
    postNewList(payload(list));
  }

  const payload = (list) => (
    {
      data: {
        ...list,
        relationships: {
          project: {
            data: {
              type: 'projects',
              id: props.projectId
            }
          }
        }
      }
    }
  );

  return(
    <>
      <HorizontalScrollGrid
        className='ui five column grid'
        style={{display: 'block'}}
      >
        {
          (lists.pending && 'Loading...') ||
          (lists.completed && <TaskListList lists={lists.response.data} />)
        }

        <div className="column" style={{height: '100%'}}>
          <ToggleableListForm
            onFormSubmit={handleCreateFormSubmit}
            list={list}
          />
        </div>
      </HorizontalScrollGrid>
    </>
  );
}
