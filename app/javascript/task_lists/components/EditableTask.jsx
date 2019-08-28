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
    const uniqueProjectMembers = projectMembers.response.data.filter(obj1 => {
      return !members.some(obj2 => {
        return obj1.id === obj2.id;
      })
    });

    const uniqueMembers = members.filter(obj1 => {
      return !projectMembers.response.data.some(obj2 => {
        return obj1.id == obj2.id;
      });
    });

    return uniqueProjectMembers.concat(uniqueMembers);

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
      const taskMembers = includedMembers.filter(obj1 => {
        return task.relationships.members.data.find(obj2 => {
          return obj1.id === obj2.id;
        })
      }); 

      setMembers(taskMembers);
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
