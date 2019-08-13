import React, { useState, useEffect, useRef, useReducer } from 'react';

const BASE_URL = process.env.REACT_APP_API_HOST


const types = {
  REQUEST: 'REQUEST',
  SUCCESS: 'SUCCESS',
  ERROR: 'ERROR',
  SET: 'SET',
  UPDATE: 'UPDATE'
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

const update = (state, action) => {

  const updatedDatumIdx = state.response.data.findIndex(
    datum => datum.id === action.datum.id
  );

  return(
    Object.assign({...state}, {
      response: Object.assign({...state.response}, {
        data: Object.assign([...state.response.data], {
          [updatedDatumIdx]: action.datum
        })
      })
    })
  );
}

const resReducer = (state, action) => {
  switch (action.type) {
    case 'UPDATE':
      return update(state, action)
    case 'SET':
      return Object.assign({...state}, {
        response: Object.assign({...state.response}, {
          data: state.response.data.concat(action.datum)
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

export const useEndpoint = (fn) => {

  const initialState = {
    response: null,
    pending: false,
    completed: false,
    error: false
  }

  const [res, dispatch] = useReducer(resReducer, initialState);

  const [req, setReq] = useState();

  const setData = (datum) => {
    dispatch({
      type: types.SET,
      datum
    });
  }

  const updateData = (datum) => {
    dispatch({
      type: types.UPDATE,
      datum
    })
  }

  function checkStatus(res) {
    if(res.status == 404) {
      return Promise.reject();
    }

    return res;
  }

  let _isMounted = false;

  async function execute(request) {
    dispatch(actions.request());

    await fetch(request)
      .then(res => checkStatus(res))
      .then(res => res.json())
      .then(
        (res) => {
          if (_isMounted) {
            dispatch(actions.success(res))
          }
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

    _isMounted = true;
    execute(request);

    return () => {
      _isMounted = false;
    }

  }, [req]);

  return [res, (...args) => setReq(fn(...args)), setData, updateData];
}
