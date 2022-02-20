import React from "react";
import { Link } from "react-router-dom";
import { useHistory } from "react-router-dom";
import {
  Button,
  Card,
  CardBody,
  FormGroup,
  CustomInput,
  Modal,
  ModalBody,
  ModalFooter,
  ModalHeader,
} from "reactstrap";
import { Formik, FastField, Form, ErrorMessage } from "formik";
import * as Yup from "yup";

import { ReactstrapInput } from "reactstrap-formik";
import LoginApi from "../../api/LoginApi";
import UserApi from "../../api/UserApi";
import { toastr } from "react-redux-toastr";
import storage from "../../storage/Storage";
import { useState } from "react";
import {
  setTokenInfo,
  setUserLoginInfo,
  setRememberMeInfo,
} from "../../redux/actions/userLoginInfoActions";
import avatar from "../../assets/img/avatars/avatar.jpg";
import { selectRememberMe } from "../../redux/selectors/userLoginInfoSelector";
import { connect } from "react-redux";

const SignIn = (props) => {
  const [isOpenModal, setOpenModal] = useState(false);
  const [isDisabledResendEmailButton, setDisabledResendEmailButton] =
    useState(false);
  const [email, setEmail] = useState("");
  const [isRememberMe, setRememberMe] = useState(props.isRememberMe);
  const showWrongLoginNotification = (title, message) => {
    const options = {
      timeOut: 2500,
      showCloseButton: false,
      progressBar: false,
      position: "top-right",
    };

    // show notification
    toastr.error(title, message, options);
  };

  const resendEmailToActiveAccount = async () => {
    setDisabledResendEmailButton(true);
    // call api
    await UserApi.resendEmailToActiveAccount(email);
    setDisabledResendEmailButton(false);
  };
  const history = useHistory();

  const handleSignUp = () => {
    history.push("/auth/sign-up");
  };
  return (
    <React.Fragment>
      <div className="text-center mt-4">
        <h2>Welcome back!!!</h2>
        <p className="lead">Sign in to your account to continue</p>
      </div>
      <Formik
        initialValues={{
          username: "",
          password: "",
          errorForm: "",
        }}
        validationSchema={Yup.object({
          username: Yup.string()
            .required("Required")
            .max(50, "Must be between 6 to 50 characters")
            .min(6, "Must be between 6 to 50 characters"),

          password: Yup.string()
            .max(50, "Must be between 6 to 50 characters")
            .min(6, "Must be between 6 to 50 characters")
            .required("Required"),
        })}
        onSubmit={async (values, { setFieldError }) => {
          try {
            // call api
            const result = await LoginApi.login(
              values.username,
              values.password
            );
            // login successfully!
            // account not active
            if (result.status === "NOT_ACTIVE") {
              // open model
              setOpenModal(true);
              setEmail(result.email);
            } else {
              console.log(storage.setRememberMe(isRememberMe));
              storage.setRememberMe(isRememberMe);

              //   save token to storage
              storage.setToken(result.token);
              // save user info to storage
              const user = {
                firstname: result.firstName,
                lastname: result.lastName,
                username: result.userName,
                email: result.email,
                role: result.role,
                status: result.status,
              };
              // save remember me to redux
              props.setRememberMeInfo(isRememberMe);
              // save token to redux
              props.setTokenInfo(result.token);
              // save user info to redux
              props.setUserLoginInfo(user);
              storage.setUserInfo(user);
              props.history.push("/dashboard/default");
            }

            //

            //         // redirect home page
            //         props.history.push("/dashboard/default");
            //       }
          } catch (error) {
            if (error.status === 401) {
              showWrongLoginNotification(
                "Login Failed",
                "Wrong username or password!"
              );
            } else {
              setFieldError("errorForm", "There is an error from the server");
              console.log(error);
              alert("NG");
            }
          }
        }}
      >
        {({ isSubmitting }) => (
          <Card>
            <CardBody>
              <div className="m-sm-4">
                <div className="text-center">
                  <img
                    src={avatar}
                    alt="Chris Wood"
                    className="img-fluid rounded-circle"
                    width="132"
                    height="132"
                  />
                </div>
                <Form>
                  {/* username */}
                  <FormGroup>
                    <FastField
                      label="Username"
                      bsSize="lg"
                      type="text"
                      name="username"
                      placeholder="Enter your username"
                      component={ReactstrapInput}
                    />
                  </FormGroup>

                  {/* password */}
                  <FormGroup>
                    <FastField
                      label="Password"
                      bsSize="lg"
                      type="password"
                      name="password"
                      placeholder="Enter password"
                      component={ReactstrapInput}
                    />
                  </FormGroup>
                  <small>
                    <Link to="/auth/reset-password">Forgot password?</Link>
                  </small>

                  <div>
                    <CustomInput
                      type="checkbox"
                      id="rememberMe"
                      label="Remember me next time"
                      checked={isRememberMe}
                      onChange={(e) => setRememberMe(e.target.checked)}
                    />
                  </div>
                  <div className="text-center mt-3">
                    <Button color="primary" size="lg">
                      Sign in
                    </Button>
                  </div>
                </Form>
              </div>
            </CardBody>
          </Card>
        )}
      </Formik>
      <div className="text-center mt-4">
        {" "}
        <p> If you dont have account, please Sign Up</p>
        <Button onClick={handleSignUp} color="primary" size="lg">
          Sign Up
        </Button>
        <br />
        <br />
        <br />
        <br />
        <br />
      </div>

      <Modal isOpen={isOpenModal}>
        {/* header */}
        <ModalHeader>You need to confirm your account</ModalHeader>

        {/* body */}
        <ModalBody className="m-3">
          <p>Your account is not active.</p>
          <p>
            Please check your email (<b>{email}</b>) to active account. <br />
            If you dont find this email. Click Resend below!
          </p>
        </ModalBody>

        {/* footer */}
        <ModalFooter>
          {/* resend */}
          <Button
            color="primary"
            onClick={resendEmailToActiveAccount}
            style={{ marginLeft: 10 }}
            disabled={isDisabledResendEmailButton}
          >
            Resend
          </Button>

          {/* close button */}
          <Button color="primary" onClick={() => setOpenModal(false)}>
            Close
          </Button>
        </ModalFooter>
      </Modal>
    </React.Fragment>
  );
};

const mapGlobalStateToProps = (state) => {
  return {
    isRememberMe: selectRememberMe(state),
  };
};

export default connect(mapGlobalStateToProps, {
  setTokenInfo,
  setUserLoginInfo,
  //etRememberMeInfo,
})(SignIn);
