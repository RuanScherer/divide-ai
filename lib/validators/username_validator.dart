String? validateUsername(String? username) {
  if (username == null || username.trim().isEmpty) {
    return 'É obrigatório informar uma tag de usuário.';
  } else if (username.trim().length < 4) {
    return 'A tag de usuário deve ter ao menos 4 dígitos.';
  } else if (username.contains('@')) {
    return 'A tag de usuário não pode conter @.';
  } else if (username.contains('\\')) {
    return 'A tag de usuário não pode conter \\.';
  }
}
