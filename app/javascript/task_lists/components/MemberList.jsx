import React from 'react';
import { Header, List } from 'semantic-ui-react';

const MemberList = ({ members, ...props }) => {
  const handleDelete = (e) => {
    props.onMemberDelete(e.target.getAttribute('value'));
  }

  return(
    <>
      {
        members.map(member =>
          <div 
            className='ui label' 
            key={member.id}
          >
            {member.attributes.email}
            <i 
              className='delete icon'
              value={member.id}
              onClick={handleDelete}
            >
            </i>
          </div>
        )
      }
    </>
  )
}

export default MemberList;
