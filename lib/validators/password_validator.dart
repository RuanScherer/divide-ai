String? validatePassword(String? password) {
  if (password == null || password.trim().isEmpty) {
    return 'É obrigatório informar a senha.';
  } else if (password.trim().length < 8) {
    return 'Senha muito curta (deve ter no mínimo 8 caracteres).';
  }
}
