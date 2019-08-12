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

const ListContainer = ({ list }) => {

  const [listTasks, fetchListTasks] = useEndpoint(() => ({
    url: `lists/${list.id}/relationships/tasks`,
    method: 'GET'
  }));

  const [tasks, fetchTasks, setTasks] = useEndpoint(() => ({
    url: `${listTasks.response.links.related}`,
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

      if(listTasks.completed && !listTasks.error) {
        if(!tasks.response) fetchTasks();
      }
      
      if(task.completed && !task.error) {
        setTasks(task.response.data);
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
            pending={tasks.pending}
            completed={tasks.completed}
            tasks={tasks.response ? tasks.response.data : null}
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
