import React, { Component } from 'react'

class ListForm extends Component {
  state = {
    title: '',
    error: false,
    err_msg: '',
  }

  handleSubmit = () => {
    if(!this.isValid()) return

    const list = {
      type: 'lists',
      attributes: {
        title: this.state.title
      },
    }

    this.props.onFormSubmit(list)
  }

  isValid = () => {
    if(this.state.title.length == 0) {
      this.setState({
        ...this.state,
        error: true,
        err_msg: 'Title must be present'
      })
      return false;
    }
    return true;
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
