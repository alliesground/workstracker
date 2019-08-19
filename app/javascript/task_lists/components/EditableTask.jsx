import React, { useState, useEffect } from 'react';
import {
  Button, Header, Image, Modal, Menu 
} from 'semantic-ui-react';
import Task from './Task';
import { useToggle } from './useToggle';
import Checklist from './Checklist';
import AddTaskMemberForm from './AddTaskMemberForm'
import MemberList from './MemberList'
import { useEndpoint } from './useEndpoint';
import WithLoading from '../hocs/WithLoading';

const MemberListWithLoading = WithLoading(MemberList);

const EditableTask = ({ task, projectId }) => {

  const [modalOpen, toggleModalOpen] = useToggle();

  const [filteredProjectMembers, setFilteredProjectMembers] = useState();

  const [members, fetchMembers, setMembers] = useEndpoint(() => ({
    url: `/tasks/${task.id}/members`,
    method: 'GET'
  }));

  const [projectMembers, fetchProjectMembers] = useEndpoint(() => ({
    url: `/projects/${projectId}/members`,
    method: 'GET'
  }));

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
    /*
    const newMembers = Object.assign({...members}, {
      response: Object.assign({...members.response}, {
        data: members.response.data.concat(member)
      })
    })*/

    setMembers(member);
  }

  useEffect(() => {
    fetchMembers();
    fetchProjectMembers();
  }, []);

  useEffect(() => {
    if (members.response && projectMembers.response) {
      setFilteredProjectMembers(filterProjectMembers());
    }
  }, [members, projectMembers]);
  
  return(
    <Modal 
      trigger={
        <Task 
          onClick={toggleModalOpen}
          task={task}
          members={members}
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

        <Header>Members</Header>
        <MemberListWithLoading 
          pending={members.pending}
          completed={members.completed}
          members={members}
        />

        <Checklist 
          taskId={task.id} 
        />
      </Modal.Content>
    </Modal>
  );
}

export default EditableTask;
