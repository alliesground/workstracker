import React, { useState, useEffect, useReducer } from 'react';

const BASE_URL = 'https://jsonplaceholder.typicode.com';

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
      return Object.assign({}, state, {data: state.data.concat(action.data)});
    case 'REQUEST':
      return { 
        data: null,
        pending: true,
        completed: false,
        error: false
      }
    case 'SUCCESS':
      return { 
        data: action.res,
        pending: false,
        completed: true,
        error: false
      }
    case 'ERROR':
      return {
        data: null,
        pending: false,
        error: true,
        completed: true
      }
    default:
      throw new Error();
  }
}

export const useEndpoint = (fn) => {

  const initialState = {
    data: null,
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
    })
  }

  function checkStatus(res) {
    if(res.status == 404) {
      return Promise.reject();
    }

    return res;
  }

  async function execute(request) {

    dispatch(actions.request());

    /*
    setRes({
      data: null,
      pending: true,
      completed: false,
      error: false
    });*/

    fetch(request)
      .then(res => checkStatus(res))
      .then(res => res.json())
      .then(
        (res) => {
          dispatch(actions.success(res))
          /*setRes({
            data: res,
            pending: false,
            error: false,
            completed: true
          })*/
        },
        (error) => {
          dispatch(actions.error())
          /*setRes({
            data: null,
            pending: false,
            error: true,
            completed: true
          })*/
        }
      )
  }

  useEffect(() => {
    if(!req) return;

    const {url, ...options} = req
    const request = new Request(`${BASE_URL}/${url}`, options);

    execute(request);
  }, [req]);


  //return [res, (...args) => setReq(fn(...args)), (data) => setRes({...res, data})];
  return [res, (...args) => setReq(fn(...args)), setData];
}
