import React, { useState, useEffect, useLayoutEffect } from 'react';
import ListContainers from './ListContainers';
import ToggleableListForm from './ToggleableListForm';
import styled from 'styled-components';
import { useEndpoint } from './useEndpoint';
import WithLoading from '../hocs/WithLoading';
import EditableTask from './EditableTask';
import ActionCable from 'actioncable';

const HorizontalScrollGrid = styled.div`
  overflow-x: auto;
  overflow-y: hidden;
  white-space: nowrap;
  height: calc(100vh - 144px);

  .column:first-child {
    margin-left: -12px;
  }
`;

const ListContainersWithLoading = WithLoading(ListContainers); 

export const TaskListsDashboard = (props) => {

  const editableTask = (task, includedMembers) => (
    <EditableTask
      key={task.id}
      task={task}
      projectId={props.projectId}
      includedMembers={includedMembers}
    />
  )

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

  const [broadcastedListActivity, setBroadcastedListActivity] = useState(null);

  const handleReceiveBroadcastedList = ({ response, ownerId }) => {
    console.log(response);
    if (response === null || response.data.type !== 'lists') return

    setBroadcastedListActivity({
      ...response,
      ownerId
    })
  }

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
  
  useEffect(() => {
    if (lists.completed && !lists.error) {
    }
  }, [lists]);

  useEffect(() => {
    const execute = () => {

      if(!projectLists.pending && !projectLists.completed) {
        fetchProjectLists(); 
      }

      if(projectLists.completed && !projectLists.error) {
        if(!lists.response) fetchLists();
      }
    }

    execute();

  }, [projectLists]);
  
  useEffect(() => {

    const execute = () => {
      if(list.completed && !list.error) {
        setLists(list.response.data);
      }
    };

    execute();

  }, [list]);

  useEffect(() => {
    const cable = ActionCable.createConsumer('ws:localhost:3000/cable');
    cable.subscriptions.create(
      {
        channel: 'ActivitiesChannel',
        project_id: props.projectId
      }, {
      received: handleReceiveBroadcastedList
    });

  }, []);

  useEffect(() => {
    if (broadcastedListActivity === null) return;

    if (!(broadcastedListActivity.ownerId == props.current_user_id)) {
      setLists(broadcastedListActivity.data)
    }
  }, [broadcastedListActivity]); 

  return(
    <>
      <HorizontalScrollGrid
        className='ui five column grid'
        style={{display: 'block'}}
      >
        <ListContainersWithLoading 
          pending={lists.pending}
          completed={lists.completed}
          lists={lists.response ? lists.response.data : null}
          editableTask={editableTask}
        />

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

