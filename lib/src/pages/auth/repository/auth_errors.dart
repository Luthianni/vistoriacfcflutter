String authErrorsString(String? code) {
  const errorMessages = {
    "BAD_REQUEST": 'Username e/ou senha inválidos',
    "Invalid session token": 'Token inválido',
    '"Http status error [401]"': 'Sem permissão',
  };

  return errorMessages[code] ?? 'Um erro indefinido ocorreu';
}

