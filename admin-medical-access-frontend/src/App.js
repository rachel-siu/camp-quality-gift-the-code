import React, { Component } from 'react';
import './App.css';
import axios from "axios"

import history from "./history"
import { Router, Route, Switch } from 'react-router-dom';


// landing page
import Home from "./pages/landingPage/index"

// session selection
import SessionSelection from "./pages/sessionSelection/index"

// campers list
import Campers from "./pages/campers/index"

// camper profile
import CamperProfile from "./pages/camperProfile/index"


const testSessions = [{id: 1, startDate: "12/20/20", endDate: "12/27/20"}, {id: 2, startDate: "1/5/18", endDate: "1/12/18"}]
const campers =
[
  {id: 1, firstName: "john", lastName: "doe", disease: "skin cancer", medAdministered: true, },
  {id: 2, firstName: "susan", lastName: "sue", disease: "breast cancer", medAdministered: false, },
  {id: 3, firstName: "ryan", lastName: "ray", disease: "testicular cancer", medAdministered: false, },
  {id: 3, firstName: "joe", lastName: "john", disease: "none", medAdministered: true, },
]



class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      isLoggedIn: false,
      campLocation: "test",
      currentSessionInfo: {},
      sessions: testSessions,
      currentSessionID: "",
      campers: campers
    }
  }

  _handleLogin = e => {
    e.preventDefault();
    const loginInfo = {
      email: e.target.email.value,
      password: e.target.password.value
    }
    const options = {
      method: "POST",
      headers: {'content-type': 'application/json'},
      data: loginInfo,
      url: 'http://localhost:3002/login/'
    }
    axios(options)
      .then(response => {
        if (response.data.valid) {
          this.setState({
            isLoggedIn: true,
            campLocation: this.campLocation
          }, () => {
            history.push("/session_select")
          })
        }
      })
  }

  _handleSessionSelection = e => {
    e.preventDefault()
    this.setState({
      currentSessionID: e.target.sessionID.value
    }, () => {

      history.push("/camper_list")

      // const options = {
      //   method: "POST",
      //   headers: {'content-type': 'application/json'},
      //   data: this.state.currentSessionID,
      //   url: ''
      // }

      // axios(options)
      //   .then(response => {
      //     if (response.data.length > 0) {
      //       this.setState({
      //         // campers: response.data
      //         campers: campers
      //       }, () => {
      //         history.push("/camper_list")
      //       })
      //     }
      //   })
      //   .catch((err) => {
      //     throw err
      //   })

    })
  }


  render() {
    return (
      <Router history={ history } >
        <Switch>
          <Route exact path="/" render={() => <Home handleLogin={this._handleLogin} /> } />
          <Route exact path="/session_select" render={() => <SessionSelection campLocation={this.state.campLocation} sessions={this.state.sessions} handleSessionSelection={this._handleSessionSelection} /> } />
          <Route exact path="/camper_list" render={() => <Campers campers={this.state.campers} /> } />
          <Route path="/camper_profile/" render={() => <CamperProfile /> }/>
        </Switch>

      </Router>
    );
  }
}

export default App;
