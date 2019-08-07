import React from 'react';
import EditableList from './EditableList'

const EditableLists = ({ lists }) => (
  lists.map(list => (
    <EditableList list={list} />
  ))
);

export default EditableLists
