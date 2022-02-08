String? validatePassword(String? password) {
  if (password == null || password.trim().isEmpty) {
    return 'É obrigatório informar a senha.';
  } else if (password.trim().length < 8) {
    return 'Senha muito curta (deve ter no mínimo 8 caracteres).';
  }
}

String? validatePasswordConfirmation(
  String? password,
  String? passwordConfirmation,
) {
  if (passwordConfirmation != null && password != passwordConfirmation) {
    return 'A senha e confirmação de senha devem ser iguais.';
  }
}
