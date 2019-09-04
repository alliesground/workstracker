import React, { useState, useEffect, useContext } from 'react';
import styled from 'styled-components';
import ToggleableTaskForm from './ToggleableTaskForm'
import EditableTasks from './EditableTasks';
import { useEndpoint } from './useEndpoint';
import WithLoading from '../hocs/WithLoading';
import ActionCable from 'actioncable';
import CurrentUserContext from './CurrentUserContext';
import CurrentProjectContext from './CurrentProjectContext';

const Card = styled.div`
  max-height: 100%;
  overflow-y: auto;
  overflow-x: hidden;
  white-space: normal;
`;

const EditableTasksWithLoading =  WithLoading(EditableTasks);

const ListContainer = ({ list, ...props }) => {
  const current_user = useContext(CurrentUserContext);
  const current_project = useContext(CurrentProjectContext);

  const [listTasks, fetchListTasks, setListTasks] = useEndpoint(() => ({
    url: `lists/${list.id}/tasks?include=members`,
    method: 'GET'
  }));

  const [task, postNewTask] = useEndpoint(data => ({
    url: 'tasks?include=members',
    method: 'POST',
    body: JSON.stringify(data),
    headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
    }
  })); 

  const handleCreateFormSubmit = (task) => {
    postNewTask(payload(task))
  }

  const payload = (task) => (
    {
      data: {
        ...task,
        relationships: {
          list: {
            data: {
              type: 'lists',
              id: list.id
            }
          }
        }
      }
    }
  );

  const [broadcastedTask, setBroadcastedTask] = useState(null);

  const handleReceiveBroadcastedTask = ({ response }) => {
    if (response === null) return

    setBroadcastedTask({
      ...response
    })
  }

  useEffect(() => {
    const consumer = ActionCable.createConsumer(process.env.REACT_APP_WS_HOST);
    consumer.subscriptions.create(
      {
        channel: 'TasksChannel',
        list_id: list.id
      }, {
      received: handleReceiveBroadcastedTask
    });

  }, []);

  useEffect(() => {

    const execute = () => {

      if(!listTasks.pending && !listTasks.completed) {
        fetchListTasks();
      }
      
    };

    execute();

  }, [listTasks]);

  useEffect(() => {
    if (broadcastedTask === null) return;

    setListTasks(broadcastedTask.data)

  }, [broadcastedTask]);

  return(
    <div className='column' style={{height: '100%'}}>
      <Card className='ui fluid card'>
        <div className='content'>
          <div className='header'>
            { list.attributes.title }
          </div>
          <EditableTasksWithLoading 
            pending={listTasks.pending}
            completed={listTasks.completed}
            tasks={listTasks.response ? listTasks.response.data : null}
            includedMembers={listTasks.response ? listTasks.response.included : null}
            editableTask={props.editableTask}
          />
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
