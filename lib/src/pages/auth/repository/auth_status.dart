enum AuthStatus {
  /// O usuário não está autenticado
  unauthenticated,
  
  /// O processo de autenticação está em andamento
  authenticating,
  
  /// O usuário está autenticado com sucesso
  authenticated,
  
  /// Ocorreu um erro durante a autenticação
  error,
  
  /// O token de autenticação expirou
  tokenExpired,

  /// O usuário foi deslogado
  signedOut
}

// Extensão para adicionar funcionalidades úteis ao enum
extension AuthStatusExtension on AuthStatus {
  bool get isAuthenticated => this == AuthStatus.authenticated;
  
  bool get isAuthenticating => this == AuthStatus.authenticating;
  
  bool get isUnauthenticated => 
    this == AuthStatus.unauthenticated || 
    this == AuthStatus.signedOut ||
    this == AuthStatus.tokenExpired;
    
  bool get hasError => this == AuthStatus.error;
}