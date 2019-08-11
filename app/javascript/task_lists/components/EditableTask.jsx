import React, { useState } from 'react';
import { 
  Button, Header, Image, Modal, Menu
} from 'semantic-ui-react';
import Task from './Task';
import { useToggle } from './useToggle';
import TodoList from './TodoList';
import Todo from './Todo';

const EditableTask = ({ task }) => {
  const [modalOpen, toggleModalOpen] = useToggle();
  const todos = [
    {
      id: 1,
      attributes: {
        title: 'First Task'
      }
    },
    {
      id: 2,
      attributes: {
        title: 'Second Task'
      }
    },
    {
      id: 3,
      attributes: {
        title: 'Third Task'
      }
    }
  ];
  
  return(
    <Modal 
      trigger={
        <Task 
          onClick={toggleModalOpen}
          task={task}
        />
      } 
      open={modalOpen}
      onClose={toggleModalOpen}
      size='tiny'
      style={{top:'10%'}}
    >
      <Modal.Header>{task.attributes.title}</Modal.Header>
      <Modal.Content>
        <Menu secondary>
          <Menu.Item>
            <Button>Add Member</Button>
          </Menu.Item>
        </Menu>

        <Header>CheckList</Header>
        <TodoList 
          todos={todos}
        />
      </Modal.Content>
    </Modal>
  );
}

export default EditableTask;
