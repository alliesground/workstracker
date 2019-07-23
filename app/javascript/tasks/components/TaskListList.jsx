import React, { Component } from 'react'
import ToggleableListForm from './ToggleableListForm';

class TaskListList extends Component {
  constructor(props) {
    super(props);

    this.state = {
      lists: [
        { title: 'Backlog' },
        { title: 'Doing' },
        { title: 'Done' },
        { title: 'Raw Ideas' },
      ]
    }
  }

  handleCreateFormSubmit = (list) => {
    this.setState({
      lists: this.state.lists.concat(list)
    })
  }

  render() {
    const lists = this.state.lists.map((list) => (
      <div className='column'>
        <div className='ui card'>
          <div className='content'>
            <div className='header'>
              { list.title }
            </div>
          </div>
        </div>
      </div>
    ));

    return(
      <div className='ui five column grid'>
        <ToggleableListForm 
          onFormSubmit={this.handleCreateFormSubmit}
        />
        {lists}
      </div>
    );
  }
}

export default TaskListList
