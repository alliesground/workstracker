import React from 'react';
import { Header, List } from 'semantic-ui-react';

const MemberList = ({ members }) => (
  <>
    <Header>Members</Header>
    <List relaxed>
      {
        members.map(member =>
          <List.Item>
          {member.attributes.name}
          </List.Item>
        )
      }
    </List>
  </>
)

export default MemberList;
