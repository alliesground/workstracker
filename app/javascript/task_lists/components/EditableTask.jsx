import React, { useState, useEffect } from 'react';
import { Button, Header, Image, Modal } from 'semantic-ui-react';
import Task from './Task';
import { useToggle } from './useToggle';

const EditableTask = ({ task }) => {
  const [modalOpen, setModalOpen, setModalClose] = useToggle(); 
  
  console.log(modalOpen);
  return(
    <Modal 
      trigger={
        <Task 
          onClick={setModalOpen}
          task={task}
        />
      } 
      open={modalOpen}
      onClose={setModalClose}
      size='mini'
    >
      <Modal.Content>
        Content coming soon...
      </Modal.Content>
    </Modal>
  );
}

export default EditableTask;
