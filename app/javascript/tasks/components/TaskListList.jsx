import React, { Component } from 'react'
import ToggleableListForm from './ToggleableListForm';
import styled from 'styled-components';

const HorizontalScrollGrid = styled.div`
  overflow-x: auto;
  overflow-y: hidden;
  white-space: nowrap;
  height: calc(100vh - 144px);
`;

const List = styled.div`
  height: 100%;
`;

const Card = styled.div`
  max-height: 100%;
  overflow-y: auto;
  overflow-x: hidden;
  white-space: normal;
`;


class TaskListList extends Component {
  constructor(props) {
    super(props);

    this.state = {
      lists: [
        { 
          title: 'Backlog'
        }
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
      <List className='column'>
        <Card className='ui card'>
          <div className='content'>
            <div className='header'>
              { list.title }
            </div>
            <div className='description'>
              <p>{ list.description }</p>
            </div>
          </div>
        </Card>
      </List>
    ));

    return(
      <HorizontalScrollGrid
        className='ui five column grid'
        style={{display: 'block'}}
      >
        {lists}

        <List className="column">
          <ToggleableListForm 
            onFormSubmit={this.handleCreateFormSubmit}
          />
        </List>
      </HorizontalScrollGrid>
    );
  }
}

export default TaskListList
