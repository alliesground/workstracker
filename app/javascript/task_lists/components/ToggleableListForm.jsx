import React, { useState, useEffect } from 'react'
import ListForm from './ListForm';
import { useToggle } from './useToggle';

const ToggleableListForm = (props) => {

  const [isOpen, toggleIsOpen] = useToggle();

  const handleFormSubmit = (list) => {
    props.onFormSubmit(list);
  }

  useEffect(() => {
    const execute = async () => {
      if(props.list.completed && !props.list.error) {
        if(isOpen) toggleIsOpen();
      }
    };

    execute();
  }, [props.list]);

  return(
    <>
      {
        isOpen ? 
        (props.list.pending ? 'Loading...' : <ListForm 
          onFormSubmit={handleFormSubmit}
          onFormCancel={toggleIsOpen}
          list={props.list}
         />)
        :
        <button 
          className="circular ui icon button blue"
          onClick={toggleIsOpen}
        >
          <i className='large icon plus'></i>
        </button>
      }
    </>
  );
}

export default ToggleableListForm
