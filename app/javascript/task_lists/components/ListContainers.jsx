import React from 'react';
import ListContainer from './ListContainer'

const ListContainers = ({ lists, projectId }) => (
  lists.map(list => (
    <ListContainer 
      key={list.id} 
      list={list} 
      projectId={projectId}
    />
  ))
);

export default ListContainers
