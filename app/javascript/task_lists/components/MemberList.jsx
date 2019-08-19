import React from 'react';
import { Header, List } from 'semantic-ui-react';

const MemberList = ({ members }) => (
  <>
    <List relaxed>
      {
        members.response.data.map(member =>
          <List.Item key={member.id}>
          {member.attributes.email}
          </List.Item>
        )
      }
    </List>
  </>
)

export default MemberList;
