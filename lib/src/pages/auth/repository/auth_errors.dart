String authErrorsString(String? code) {
  switch (code) {
    case "BAD_REQUEST":
      return 'Username e/ou senha inválidos';

    case 'Invalid session token':
      return 'Token inválido';

    default:
      return 'Um erro indefinido ocorreu';
  }
}
