import React, { Component } from 'react';
import TaskListList from './TaskListList';
import ToggleableListForm from './ToggleableListForm';
import styled from 'styled-components';
import { client } from '../../Client';

const HorizontalScrollGrid = styled.div`
  overflow-x: auto;
  overflow-y: hidden;
  white-space: nowrap;
  height: calc(100vh - 144px);
`;


class TaskListDashboard extends Component {
  constructor(props) {
    super(props);

    this.state = {
      lists: [
        { 
          name: 'Backlog'
        }
      ]
    }
  }

  componentDidMount() {
    client.getUsers().then(
      (response) => {
        this.setState({
          lists: response
        })
      },
      (error) => {}
    );
  }

  handleCreateFormSubmit = (list) => {
    client.createList(list).then(
      (response) => {
        console.log(response);
      },
      (error) => {}
    );

    this.setState({
      lists: this.state.lists.concat(list)
    })
  }

  render() {

    return(
      <HorizontalScrollGrid
        className='ui five column grid'
        style={{display: 'block'}}
      >
        <TaskListList lists={this.state.lists} />

        <div className="column" style={{height: '100%'}}>
          <ToggleableListForm 
            onFormSubmit={this.handleCreateFormSubmit}
          />
        </div>
      </HorizontalScrollGrid>
    );
  }
}


export default TaskListDashboard
