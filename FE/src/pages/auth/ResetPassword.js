import React from "react";
import { Link } from "react-router-dom";
import { Formik, FastField, Form, ErrorMessage } from "formik";
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
import * as Yup from "yup";
import UserApi from "../../api/UserApi";
import { ReactstrapInput } from "reactstrap-formik";
import { useState } from "react";

const ResetPassword = (props) => {
  const [isOpenModal, setOpenModal] = useState(false);
  const [isLoadingModal, setLoadingModal] = useState(false);
  const [email, setEmail] = useState("");
  const [isDisabledResendEmailButton, setDisabledResendEmailButton] =
    useState(false);

  const handleCloseModel = () => {
    // open model
    setOpenModal(false);
  };

  const handleLoginModel = () => {
    // open model
    setOpenModal(false);
    // redirect login page
    props.history.push("/auth/sign-in");
  };

  const resendEmailToResetPassword = async () => {
    setDisabledResendEmailButton(true);
    // call api
    await UserApi.resendEmailToResetPassword(email);
    setDisabledResendEmailButton(false);
  };
  return (
    <>
      <div className="text-center mt-4">
        <h1 className="h2">Reset password</h1>
        <p className="lead">Enter your email to reset your password.</p>
      </div>

      <div className="m-sm-4">
        <Formik
          initialValues={{
            email: "",
          }}
          validationSchema={Yup.object({
            email: Yup.string()
              .required("Required")
              .max(50, "Must be between 6 to 50 characters")
              .min(6, "Must be between 6 to 50 characters")
              .email("Invalid email address")
              .test(
                "checkUniqueEmail",
                "This email is not exist.",
                async (email) => {
                  // call api
                  const isExists = await UserApi.existsByEmail(email);
                  console.log(isExists);
                  return isExists;
                }
              ),
          })}
          onSubmit={async (values, { setFieldError }) => {
            try {
              // call api
              setLoadingModal(true);
              await UserApi.requestResetPassword(values.email);
              setLoadingModal(false);
              // open model
              setOpenModal(true);
              setEmail(values.email);
            } catch (error) {
              setFieldError("errorForm", "There is an error from the server");
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
                        type="email"
                        bsSize="lg"
                        label="Email"
                        name="email"
                        id="email"
                        placeholder="Enter your email"
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
                        Reset password
                      </Button>
                    </div>
                  </Form>
                </div>
              </CardBody>
            </Card>
          )}
        </Formik>
      </div>

      <Modal isOpen={isOpenModal}>
        {/* header */}
        <ModalHeader>You need to confirm reset password</ModalHeader>

        {/* body */}
        <ModalBody className="m-3">
          <p>
            We have sent an email to <b>{email}</b>.
          </p>
          <p>Please check your email to reset password.</p>
        </ModalBody>

        {/* footer */}
        <ModalFooter>
          {/* resend */}
          <Button
            color="primary"
            onClick={resendEmailToResetPassword}
            style={{ marginLeft: 10 }}
            disabled={isDisabledResendEmailButton}
          >
            Resend
          </Button>

          {/* login */}
          <Button type="submit" color="primary" onClick={handleLoginModel}>
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
          <h3> ===))))) SENDING TO YOUR EMAIL!!!</h3>
        </ModalBody>

        {/* footer */}
        <ModalFooter>{/* resend */}</ModalFooter>
      </Modal>
    </>
  );
};
export default ResetPassword;
