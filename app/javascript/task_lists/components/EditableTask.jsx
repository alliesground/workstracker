import React, { useState, useEffect } from 'react';
import {
  Button, Header, Image, Modal, Menu 
} from 'semantic-ui-react';
import Task from './Task';
import { useToggle } from './useToggle';
import Checklist from './Checklist';
import AddTaskMemberForm from './AddTaskMemberForm'
import MemberList from './MemberList'

const EditableTask = ({ task }) => {
  const [modalOpen, toggleModalOpen] = useToggle();
  const [filteredProjectMembers, setFilteredProjectMembers] = useState();

  const projectMembers = {
    response: {
      data: [
        {
          id: 1,
          attributes: {
            name: 'Tylon'
          }
        },
        {
          id: 2,
          attributes: {
            name: 'Manus'
          }
        },
        {
          id: 3,
          attributes: {
            name: 'Tim'
          }
        }
      ]
    }
  }

  const initialMembers = {
    response: {
      data: [
        {
          id: 1,
          attributes: {
            name: 'Tylon'
          }
        },
        {
          id: 2,
          attributes: {
            name: 'Jerry'
          }
        }
      ]
    }
  }

  const [members, setMembers] = useState(initialMembers)

  const filterProjectMembers = () => {
    const possibleMembers = [...projectMembers.response.data];

    loop1:
    for(var i in possibleMembers) {
      loop2:
      for(var j in members.response.data) {

        if(possibleMembers[i].id == members.response.data[j].id) {
          delete possibleMembers[i];
          break loop2;
        }
      }
    }

    return possibleMembers.filter(possibleMember => 
      possibleMember !== undefined
    )
  }

  const handleAddMember = (member) => {
    const newMembers = Object.assign({...members}, {
      response: Object.assign({...members.response}, {
        data: members.response.data.concat(member)
      })
    })

    setMembers(newMembers);
  }

  useEffect(() => {
    setFilteredProjectMembers(filterProjectMembers());
  }, [members]);
  
  return(
    <Modal 
      trigger={
        <Task 
          onClick={toggleModalOpen}
          task={task}
          members={members.response.data}
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
          <Menu.Item
            style={{paddingLeft:'0px'}}
          >
            <AddTaskMemberForm
              onFormSubmit={handleAddMember}
              possibleMembers={filteredProjectMembers}
            />
          </Menu.Item>
        </Menu>

        <MemberList members={members.response.data}/>

        <Checklist 
          taskId={task.id} 
          todosLink={task.relationships.todos.links.related}
        />
      </Modal.Content>
    </Modal>
  );
}

export default EditableTask;
