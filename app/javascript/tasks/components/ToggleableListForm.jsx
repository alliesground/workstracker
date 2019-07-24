import React, { Component } from 'react'
import ListForm from './ListForm'

class ToggleableListForm extends Component {
  constructor(props) {
    super(props);
    
    this.state = {
      isOpen: false
    }
  }

  handleFormOpen = () => {
    this.setState({ isOpen: true });
  }

  handleFormSubmit = (list) => {
    this.props.onFormSubmit(list);
    this.setState({ isOpen: false });
  }

  handleFormCancel = () => {
    this.setState({ isOpen: false });
  }

  render() {
    if ( this.state.isOpen ) {
      return(
        <ListForm  
          onFormSubmit={this.handleFormSubmit}
          onFormCancel={this.handleFormCancel}
        />
      );
    } else {
      return(
        <button 
          className="circular ui icon button blue"
          onClick={this.handleFormOpen}
        >
          <i className='large icon plus'></i>
        </button>
      );
    }
  }
}

export default ToggleableListForm
