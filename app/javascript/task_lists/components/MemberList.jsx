import React from 'react';
import { Header, List } from 'semantic-ui-react';

const MemberList = ({ members }) => (
  <>
    <List relaxed>
      {
        members.map(member =>
          <List.Item key={member.id}>
          {member.attributes.name}
          </List.Item>
        )
      }
    </List>
  </>
)

export default MemberList;
