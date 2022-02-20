import Api from "./Api";

const url = "/users";

const existsByEmail = (email) => {
  return Api.get(`${url}/email/${email}`);
};

const existsByUserName = (userName) => {
  return Api.get(`${url}/userName/${userName}`);
};

const resendEmailToActiveAccount = (email) => {
  const requestParams = {
    email: email,
  };

  return Api.get(`${url}/userRegistrationConfirmRequest`, {
    params: requestParams,
  });
};

const create = (username, email, password, firstname, lastname) => {
  const body = {
    userName: username,
    email: email,
    password: password,
    firstName: firstname,
    lastName: lastname,
  };
  return Api.post(url, body);
};

const requestResetPassword = (email) => {
  const requestParams = {
    email: email,
  };

  return Api.get(`${url}/resetPasswordRequest`, { params: requestParams });
};

const resendEmailToResetPassword = (email) => {
  const requestParams = {
    email: email,
  };

  return Api.get(`${url}/resendResetPassword`, { params: requestParams });
};

const resetPassword = (token, newPassword) => {
  const requestParams = {
    token: token,
    newPassword: newPassword,
  };

  return Api.get(`${url}/resetPassword`, { params: requestParams });
};

const getProfile = () => {
  return Api.get(`${url}/profile`);
};

// const getAll = () => {
//   return Api.get(url);
// };

// const getByID = (id) => {
//   return Api.get(`${url}/${id}`);
// };

// const updateByID = (id, body) => {
//   return Api.put(`${url}/${id}`, body);
// };

// const deleteByID = (id) => {
//   return Api.delete(`${url}/${id}`);
// };

// export
const UserApi = {
  // getAll,
  // getByID,

  create,
  // updateByID,
  // deleteByID,
  existsByEmail,
  existsByUserName,
  resendEmailToActiveAccount,
  requestResetPassword,
  resendEmailToResetPassword,
  resetPassword,
  getProfile,
};
export default UserApi;
