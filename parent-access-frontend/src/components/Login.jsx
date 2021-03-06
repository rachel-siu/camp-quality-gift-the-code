import React from "react";
import { Link } from "react-router-dom";

const Login = () => {
  return (
    <div>
      <div className="login-form">
        <div className="input-container">
          <label htmlFor="user_email">Email:</label>
          <input name="user_email" type="email" required />
        </div>

        <div className="input-container">
          <label htmlFor="user_password">Password:</label>
          <input name="user_password" type="password" required />
        </div>

        <Link to="/home">
          <div className="login-button">Login</div>
        </Link>
      </div>

    </div>
  )
};

export default Login;
