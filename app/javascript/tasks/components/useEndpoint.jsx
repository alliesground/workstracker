import React, { useState, useEffect, useReducer } from 'react';

const BASE_URL = process.env.REACT_APP_API_HOST


const types = {
  REQUEST: 'REQUEST',
  SUCCESS: 'SUCCESS',
  ERROR: 'ERROR',
  SET_DATA: 'SET_DATA'
}

const actions = {
  request: () => ({
    type: types.REQUEST
  }),
  success: (res) => ({
    type: types.SUCCESS,
    res
  }),
  error: () => ({
    type: types.ERROR
  })
}

const resReducer = (state, action) => {
  switch (action.type) {
    case 'SET_DATA':
      return Object.assign({}, state, {
        response: Object.assign({}, state.response, {
          data: state.response.data.concat(newDataWithId(state, action))
        })
      });
    case 'REQUEST':
      return { 
        response: null,
        pending: true,
        completed: false,
        error: false
      }
    case 'SUCCESS':
      return { 
        response: action.res,
        pending: false,
        completed: true,
        error: false
      }
    case 'ERROR':
      return {
        response: null,
        pending: false,
        error: true,
        completed: true
      }
    default:
      throw new Error();
  }
}

const newDataWithId = (state, action) => {
  let id = state.response.data[state.response.data.length - 1].id;
  id = parseInt(id, 10) + 1;

  return {
    ...action.data,
    id: id.toString()
  }
}

export const useEndpoint = (fn) => {

  const initialState = {
    response: null,
    pending: false,
    completed: false,
    error: false
  }

  const [res, dispatch] = useReducer(resReducer, initialState);

  const [req, setReq] = useState();

  const setData = (data) => {
    dispatch({
      type: types.SET_DATA,
      data
    });
  }

  function checkStatus(res) {
    if(res.status == 404) {
      return Promise.reject();
    }

    return res;
  }

  async function execute(request) {

    dispatch(actions.request());

    fetch(request)
      .then(res => checkStatus(res))
      .then(res => res.json())
      .then(
        (res) => {
          dispatch(actions.success(res))
        },
        (error) => {
          dispatch(actions.error())
        }
      )
  }

  const fullUrl = (url) => {
    const parsedUrl = url.replace(BASE_URL, '');
    return `${BASE_URL}/${parsedUrl}`;
  }

  useEffect(() => {
    if(!req) return;

    const {url, ...options} = req
    const request = new Request(fullUrl(url), options);

    execute(request);
  }, [req]);

  return [res, (...args) => setReq(fn(...args)), setData];
}
