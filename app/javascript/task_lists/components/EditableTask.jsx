import React, { useState } from 'react';
import { 
  Button, Header, Image, Modal, Menu 
} from 'semantic-ui-react';
import Task from './Task';
import { useToggle } from './useToggle';
import Checklist from './Checklist';

const EditableTask = ({ task }) => {
  const [modalOpen, toggleModalOpen] = useToggle();
  
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

        <Checklist />
      </Modal.Content>
    </Modal>
  );
}

export default EditableTask;
