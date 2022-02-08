String? validateBillEventName(String? eventName) {
  if (eventName == null || eventName.trim().isEmpty) {
    return 'É obrigatório informar o nome do evento.';
  }
}
