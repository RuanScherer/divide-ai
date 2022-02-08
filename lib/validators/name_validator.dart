String? validateName(String? name) {
  if (name == null || name.trim().isEmpty) {
    return 'É obrigatório informar o nome';
  } else if (name.trim().length < 2) {
    return 'Informe um nome válido.';
  }
}
