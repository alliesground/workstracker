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
        <div className='column'>
          <div className='ui card'>
            <button 
              className="ui button primary"
              onClick={this.handleFormOpen}
            >
              Add List
            </button>
          </div>
        </div>
      );
    }
  }
}

export default ToggleableListForm
