import React, { useState, useEffect } from 'react'
import ListForm from './ListForm'

const ToggleableListForm = (props) => {

  const [isOpen, setIsOpen] = useState(false);

  const handleFormOpen = () => {
    setIsOpen(true);
  }

  const handleFormSubmit = (list) => {
    props.onFormSubmit(list);
  }

  const handleFormCancel = () => {
    setIsOpen(false);
  }

  useEffect(() => {
    const execute = async () => {
      if(props.list.completed && !props.list.error) {
        if(isOpen) setIsOpen(false);
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
          onFormCancel={handleFormCancel}
          list={props.list}
         />)
        :
        <button 
          className="circular ui icon button blue"
          onClick={handleFormOpen}
        >
          <i className='large icon plus'></i>
        </button>
      }
    </>
  );
}

export default ToggleableListForm
