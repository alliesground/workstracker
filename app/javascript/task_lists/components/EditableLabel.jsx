import React, { useState } from 'react'
import { useToggle } from './useToggle'

const LabelForm = (props) => {

  const [title, setTitle] = useState('');

  const handleSubmit = (e) => {
    props.onFormSubmit(title);
  }

  const handleChange = (e) => {
    setTitle(e.target.value);
  }

  return(
    <>
      <textarea
        rows='2'
        value={title}
        onChange={handleChange}
      />
      <button
        className='ui compact button positive'
        onClick={handleSubmit}
      >
        Save
      </button>
      <button
        className='ui compact button negative'
      >
        Cancel
      </button>
    </>
  );
}

const EditableLabel = ({ title, onSubmit, ...rest }) => {

  const [isEdit, toggleIsEdit] = useToggle()

  const handleFormSubmit = (title) => {
    onSubmit(title);
    toggleIsEdit();
  }

  return(
    <>
      {
        isEdit ? (
          <LabelForm 
            onFormSubmit={handleFormSubmit}
          />
        ) : (
          <label
            onClick={toggleIsEdit}
            style={rest.strikeThrough ? {textDecoration:"line-through"} : null}
          >
            {title}
          </label>
        )
      }
    </>
  );
}

export default EditableLabel;
