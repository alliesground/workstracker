import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import ToggleableTaskForm from './ToggleableTaskForm'
import EditableTasks from './EditableTasks';
import { useEndpoint } from './useEndpoint';
import WithLoading from '../hocs/WithLoading';

const Card = styled.div`
  max-height: 100%;
  overflow-y: auto;
  overflow-x: hidden;
  white-space: normal;
`;

const EditableTasksWithLoading =  WithLoading(EditableTasks);

const ListContainer = ({ list, ...props }) => {

  const [listTasks, fetchListTasks, setListTasks] = useEndpoint(() => ({
    url: `lists/${list.id}/tasks`,
    method: 'GET'
  }));

  const [task, postNewTask] = useEndpoint(data => ({
    url: 'tasks',
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

  useEffect(() => {

    const execute = () => {

      if(!listTasks.pending && !listTasks.completed) {
        fetchListTasks();
      }

      
      if(task.completed && !task.error) {
        setListTasks(task.response.data);
      }
    };

    execute();

  }, [listTasks, task]);

  return(
    <div className='column' style={{height: '100%'}}>
      <Card className='ui card'>
        <div className='content'>
          <div className='header'>
            { list.attributes.title }
          </div>
          <EditableTasksWithLoading 
            pending={listTasks.pending}
            completed={listTasks.completed}
            tasks={listTasks.response ? listTasks.response.data : null}
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
