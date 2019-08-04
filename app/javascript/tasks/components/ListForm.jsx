import React, { Component } from 'react'

class ListForm extends Component {
  state = {
    title: ''
  }

  handleSubmit = () => {
    this.props.onFormSubmit({
      title: this.state.title
    })
  }

  handleTitleChange = (e) => {
    this.setState({ title: e.target.value });
  }

  render() {
    return (
      <div className="ui card">
        <div className="content">
          <div className="ui form">
            <div className="field">
              <label>Title</label>
              <input 
                type='text'
                value={this.state.title}
                onChange={this.handleTitleChange}
              />
            </div>
            <div className='ui bottom attached buttons'>
              <button 
                className='ui basic blue button'
                onClick={this.handleSubmit}
              >
                Save
              </button>
              <button
                className='ui basic red button'
                onClick={this.props.onFormCancel}
              >
                Cancel
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default ListForm
