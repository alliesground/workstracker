import React, { useState } from 'react'
import { Button, Dropdown } from 'semantic-ui-react';

const AddTaskMemberForm = (props) => {
  const handleSubmit = (e, {value}) => {
    const possibleMember = props.possibleMembers.find(
      possibleMember => possibleMember.id === value
    );

    props.onFormSubmit(possibleMember);
  }

  const possibleMembers = props.possibleMembers.map(member => (
        <Dropdown.Item 
          key={member.id}
          text={member.attributes.email} 
          value={member.id}
          onClick={handleSubmit}
        />
        ));

  return(
    <Dropdown
      text='Add Member' 
      icon='add user' 
      floating 
      labeled button
      className='icon'
    >
      <Dropdown.Menu>
        {
          props.possibleMembers.length === 0 ? (
            <Dropdown.Item 
              text='No More Members' 
            />
          ) : (
            possibleMembers
          )
        }
      </Dropdown.Menu>
    </Dropdown>
  )
}

export default AddTaskMemberForm;
