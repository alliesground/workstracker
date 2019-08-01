import React, { useState, useEffect } from 'react';

const BASE_URL = 'https://jsonplaceholder.typicode.com';

export const useEndpoint = (fn) => {
  const [res, setRes] = useState({
    data: null,
    pending: false,
    completed: false,
    error: false
  });

  const [req, setReq] = useState();

  function checkStatus(res) {
    if(res.status == 404) {
      return Promise.reject();
    }

    return res;
  }

  async function execute(request) {
    setRes({
      data: null,
      pending: true,
      completed: false,
      error: false
    });

    fetch(request)
      .then(res => checkStatus(res))
      .then(res => res.json())
      .then(
        (res) => {
          setRes({
            data: res,
            pending: false,
            error: false,
            completed: true
          })
        },
        (error) => {
          setRes({
            data: null,
            pending: false,
            error: true,
            completed: true
          })
        }
      )
  }

  useEffect(() => {
    if(!req) return;

    const {url, ...options} = req
    const request = new Request(`${BASE_URL}/${url}`, options);

    execute(request);
  }, [req]);


  return [res, (...args) => setReq(fn(...args)), (data) => setRes({...res, data})];
}
