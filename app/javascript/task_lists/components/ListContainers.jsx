import React from 'react';
import ListContainer from './ListContainer'

const ListContainers = ({ lists, ...props }) => (
  lists.map(list => (
    <ListContainer 
      key={list.id} 
      list={list} 
      editableTask={props.editableTask}
    />
  ))
);

export default ListContainers
