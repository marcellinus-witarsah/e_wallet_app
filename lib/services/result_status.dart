// Credits to : Harron Khan
// Github Link: https://github.com/haroonkhan9426/Firebase-Auth-Exception-Handling-in-Flutter

//enum for distinct error messages
enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  userNotFound,
  undefined,
}

class AuthExceptionHandler {
  static handleException(e) {
    print(e.code);
    var status;
    switch (e.code) {
      case "wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      case "email-already-in-use":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your password is wrong.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage = "The email has already been registered";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }
    return errorMessage;
  }
}
