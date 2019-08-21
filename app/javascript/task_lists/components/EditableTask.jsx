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

  const [members, fetchMembers, setMembers,, deleteMembers] = useEndpoint(() => ({
    url: `/tasks/${task.id}/members`,
    method: 'GET'
  }));

  const [projectMembers, fetchProjectMembers] = useEndpoint(() => ({
    url: `/projects/${projectId}/members`,
    method: 'GET'
  }));

  const [newAssignment, postNewAssignment] = useEndpoint(data => ({
    url: 'assignments',
    method: 'POST',
    body: JSON.stringify(data),
    headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
    },
  }));

  const [, deleteAssignment] = useEndpoint(data => (
    {
      url: 'assignments',
      method: 'DELETE',
      body: JSON.stringify(data),
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
      },
    }
  ));

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
    setMembers(member);
    postNewAssignment(payload(member))
  }

  const payload = (member) => (
    {
      data: {
        type: 'assignments',
        attributes: {
          user_id: member.id,
          task_id: task.id
        }
      }
    }
  );

  const handleMemberDelete = (memberId) => {
    deleteAssignment(
      {
        user_id: memberId,
        task_id: task.id
      }
    );

    deleteMembers({id: memberId});
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
          members={members.response && members.response.data}
          onMemberDelete={handleMemberDelete}
        />

        <Checklist 
          taskId={task.id} 
        />
      </Modal.Content>
    </Modal>
  );
}

export default EditableTask;
