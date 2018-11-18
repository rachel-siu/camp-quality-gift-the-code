import React from "react"

const LoginForm = props => (

  <form className="login100-form validate-form">
    <span className="login100-form-title p-b-26">
      Vera Admin Portal
    </span>
    <span className="login100-form-title p-b-48">
      <i className="zmdi zmdi-font"></i>
    </span>

    <div className="wrap-input100 validate-input" data-validate = "Valid email is: a@b.c">
      <input className="input100" type="text" name="username" />
      <span className="focus-input100" data-placeholder="Username"></span>
    </div>

    <div className="wrap-input100 validate-input" data-validate="Enter password">
      <span className="btn-show-pass">
        <i className="zmdi zmdi-eye"></i>
      </span>
      <input className="input100" type="password" name="password" />
      <span className="focus-input100" data-placeholder="Password"></span>
    </div>

    <div className="container-login100-form-btn">
      <div className="wrap-login100-form-btn">
        <div className="login100-form-bgbtn"></div>
        <button className="login100-form-btn">
          Login
        </button>
      </div>
    </div>

  </form>
)

export default LoginForm
