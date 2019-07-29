const API_HOST = "https://jsonplaceholder.typicode.com"

class Client {

  createList(list) {
    return fetch(`${API_HOST}/users`, {
      body: JSON.stringify(list),
      method: 'post',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/vnd.api+json',
      }
    }).then(this.checkStatus)
      .then(response => response.json());
  }


  getUsers () {
    return fetch(`${API_HOST}/users`)
      .then(this.checkStatus)
      .then(response => response.json())
  }

  checkStatus = (response) => {
    switch(true) {
      case response.status >= 200 && response.status < 300:
        return response;
      case response.status == 401:
        const error = parseValidationErrorJson(response)
        return Promise.reject(error);
    }
  }

  parseValidationErrorJson = (response) => {
    console.log('Response', response);
    const error = {}

    response.json()
      .then(json => {
        console.log('JSON', json);
        json.errors.forEach((e) => {
          error[this.getValidationErrorSource(e.source)] = e.detail;
        });
      });

    return error;
  }
}

export const client = new Client();
