String? validateEmail(String? email) {
  if (email == null || email.trim().isEmpty) {
    return 'É obrigatório informar um endereço de e-mail.';
  } else if (!email.contains('@') ||
      !email.contains('.') ||
      email.trim().length < 5) {
    return 'Endereço de e-mail inválido.';
  } else if (email.contains('\\')) {
    return 'O endereço de e-mail não pode conter \\.';
  } else if (email.contains(' ')) {
    return 'O endereço de e-mail não pode conter espaços em branco.';
  }
}
