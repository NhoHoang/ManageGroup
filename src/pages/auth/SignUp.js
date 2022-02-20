import React from "react";
import { Link } from "react-router-dom";
import { ReactstrapInput } from "reactstrap-formik";
import { FastField, Form, Formik } from "formik";
import * as Yup from "yup";
import { useState } from "react";
import { withRouter } from "react-router-dom";
import {
  Button,
  Card,
  CardBody,
  FormGroup,
  Modal,
  ModalBody,
  ModalFooter,
  ModalHeader,
} from "reactstrap";
import UserApi from "../../api/UserApi";

const SignUp = (props) => {
  const [isOpenModal, setOpenModal] = useState(false);
  const [isLoadingModal, setLoadingModal] = useState(false);

  const [email, setEmail] = useState("");
  const [isDisabledResendEmailButton, setDisabledResendEmailButton] =
    useState(false);

  const handleLoginModel = () => {
    // open model
    setOpenModal(false);
    // redirect login page
    props.history.push("/auth/sign-in");
  };

  const handleCloseModel = () => {
    // open model
    setOpenModal(false);
  };

  const resendEmailToActiveAccount = async () => {
    setDisabledResendEmailButton(true);
    // call api
    await UserApi.resendEmailToActiveAccount(email);
    setDisabledResendEmailButton(false);
  };
  return (
    <>
      <div className="text-center mt-4">
        <h1 className="h2">Get started</h1>
        <p className="lead">Start creating the best possible user !</p>
      </div>

      <Formik
        initialValues={{
          firstName: "",
          lastName: "",
          userName: "",
          email: "",
          password: "",
          confirmPassword: "",
        }}
        validationSchema={Yup.object({
          firstName: Yup.string()
            .max(50, "Not greater than 50 character ")
            .required("Required"),
          lastName: Yup.string()
            .max(50, "Not greater than 50 character ")
            .required("Required"),
          userName: Yup.string()
            .min(6, "Must greater than 6 character ")
            .max(50, "Not greater than 50 character ")
            .required("Required")
            .test(
              "checkUniqueUsername",
              "This username is already registered.",
              async (username) => {
                // call api
                const isExists = await UserApi.existsByUserName(username);
                return !isExists;
              }
            ),

          password: Yup.string()
            .min(6, "Must greater than 6 character ")
            .max(50, "Not greater than 50 character ")
            .required("Required"),
          confirmPassword: Yup.string()
            .min(6, "Must greater than 6 character ")
            .max(50, "Not greater than 50 character ")
            .required("Required")
            .when("password", {
              is: (val) => (val && val.length > 0 ? true : false),
              then: Yup.string().oneOf(
                [Yup.ref("password")],
                "Both password need to be the same"
              ),
            }),

          email: Yup.string()
            .required("Required")
            .max(50, "Must be between 6 to 50 characters")
            .min(6, "Must be between 6 to 50 characters")
            .email("Invalid email address")
            .test(
              "checkUniqueEmail",
              "This email is already registered.",
              async (email) => {
                // call api
                const isExists = await UserApi.existsByEmail(email);
                console.log(isExists);
                return !isExists;
              }
            ),
        })}
        onSubmit={async (values) => {
          try {
            // call api
            setLoadingModal(true);
            await UserApi.create(
              values.userName,
              values.email,
              values.password,
              values.firstName,
              values.lastName
            );
            setLoadingModal(false);

            // open model
            setOpenModal(true);
            setEmail(values.email);
          } catch (error) {
            console.log(error);
          }
        }}
        validateOnChange={true}
        validateOnBlur={true}
      >
        {({ isSubmitting }) => (
          <Card>
            <CardBody>
              <div className="m-sm-4">
                <Form>
                  <FormGroup>
                    <FastField
                      type="text"
                      bsSize="lg"
                      label="First name"
                      name="firstName"
                      id="firstName"
                      placeholder="Enter your firstName"
                      component={ReactstrapInput}
                    />
                  </FormGroup>

                  <FormGroup>
                    <FastField
                      type="text"
                      bsSize="lg"
                      label="Last name"
                      name="lastName"
                      id="lastName"
                      placeholder="Enter your lastName"
                      component={ReactstrapInput}
                    />
                  </FormGroup>

                  <FormGroup>
                    <FastField
                      type="text"
                      bsSize="lg"
                      label="UserName"
                      name="userName"
                      id="userName"
                      placeholder="Enter your userName"
                      component={ReactstrapInput}
                    />
                  </FormGroup>

                  <FormGroup>
                    <FastField
                      type="email"
                      bsSize="lg"
                      label="Email"
                      name="email"
                      id="email"
                      placeholder="Enter your email"
                      component={ReactstrapInput}
                    />
                  </FormGroup>

                  <FormGroup>
                    <FastField
                      type="password"
                      bsSize="lg"
                      label="Password"
                      name="password"
                      id="password"
                      placeholder="Enter your Password"
                      component={ReactstrapInput}
                    />
                  </FormGroup>

                  <FormGroup>
                    <FastField
                      type="password"
                      bsSize="lg"
                      label="Confirm Password"
                      name="confirmPassword"
                      id="confirmPassword"
                      placeholder="Enter your Password again"
                      component={ReactstrapInput}
                    />
                  </FormGroup>

                  <div className="text-center mt-3">
                    <Button
                      type="submit"
                      color="primary"
                      size="lg"
                      disabled={isSubmitting}
                    >
                      Sign up
                    </Button>
                  </div>
                </Form>
              </div>
            </CardBody>
          </Card>
        )}
      </Formik>

      <Modal isOpen={isOpenModal}>
        {/* header */}
        <ModalHeader>You need to confirm your account</ModalHeader>

        {/* body */}
        <ModalBody className="m-3">
          <p>
            We have sent an email to <b>{email}</b>.
          </p>
          <p>Please check your email to active account.</p>
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

          {/* login */}
          <Button color="primary" onClick={handleLoginModel}>
            Login
          </Button>
          <Button color="primary" onClick={handleCloseModel}>
            Close
          </Button>
        </ModalFooter>
      </Modal>

      {/* //////////////////////////////////////////////////////////////////////////////// */}
      {/* // Loading model */}
      <Modal isOpen={isLoadingModal}>
        {/* header */}
        <ModalHeader>Please wait for a second</ModalHeader>

        {/* body */}
        <ModalBody className="m-3">
          <h3>YOUR REGISTRATION IS IN PROCESS!!!</h3>
        </ModalBody>

        {/* footer */}
        <ModalFooter>{/* resend */}</ModalFooter>
      </Modal>
    </>
  );
};

export default withRouter(SignUp);
