import React from 'react';
import ListContainer from './ListContainer'

const ListContainers = ({ lists }) => (
  lists.map(list => (
    <ListContainer 
      key={list.id} 
      list={list} 
    />
  ))
);

export default ListContainers
