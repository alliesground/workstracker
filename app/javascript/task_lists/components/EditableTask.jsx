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

const EditableTask = ({ task, projectId, includedMembers }) => {

  const [modalOpen, toggleModalOpen] = useToggle();

  const [filteredProjectMembers, setFilteredProjectMembers] = useState();

  const [members, setMembers] = useState();

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
      for(var j in members) {

        if(possibleMembers[i].id == members[j].id) {
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
    setMembers(members.concat(member));
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

    const indexOfDeletedMember = members.findIndex(
      member => member.id === memberId
    )

    const remainingMembers = members.filter(
      (val, idx) => {
        return idx !== indexOfDeletedMember 
      }
    ) 

    setMembers(remainingMembers);
  }
  
  const getMembers = () => {
    if (includedMembers) {
      let uniqueIncludedMembers = includedMembers.filter(im => {
        return task.relationships.members.data.some(rm => {
          return im.id === rm.id;
        })
      });

      let uniqueRelatedMembers = task.relationships.members.data.filter(rm => {
        return !includedMembers.some(im => {
          return rm.value == im.value;
        });
      });

      setMembers(uniqueIncludedMembers.concat(uniqueRelatedMembers));
    }

  }

  useEffect(() => {
    getMembers();
    fetchProjectMembers();
  }, []);

  useEffect(() => {
    if (members && projectMembers.response) {
      setFilteredProjectMembers(filterProjectMembers());
    }
  }, [members, projectMembers]);

  return(
    <>
      {
        (members && filteredProjectMembers) &&
        <Modal 
          trigger={
            <>
              {
                <Task 
                  onClick={toggleModalOpen}
                  task={task}
                  members={members}
                />
              }
            </>
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
            <MemberList
              members={members}
              onMemberDelete={handleMemberDelete}
            />

            <Checklist 
              taskId={task.id} 
            />
          </Modal.Content>
        </Modal>
      }
    </>
  );
}

export default EditableTask;
