import 'package:divide_ai/enums/bill_creation_step_enum.dart';
import 'package:divide_ai/models/participant.dart';
import 'package:flutter/material.dart';
import 'package:divide_ai/validators/bill_validator.dart' as bill_validator;

class BillProvider extends ChangeNotifier {
  String? _eventName;
  List<Participant> _participants = [];

  bool _isEventNameValid = false;
  bool _isParticipantsValid = false;

  String? _participantsValidationMessage;

  String? get eventName => _eventName;
  List<Participant> get participants => _participants;

  bool get isEventNameValid => _isEventNameValid;

  bool get isParticipantsValid => _isParticipantsValid;

  String? get participantsValidationMessage => _participantsValidationMessage;

  void setEventName(String? eventName) {
    _eventName = eventName;
    notifyListeners();
  }

  void addParticipant(Participant participant) {
    if (checkParticipantAlreadyExists(participant)) return;

    _participants.add(participant);
    validateParticipants(_participants);
    notifyListeners();
  }

  bool checkParticipantAlreadyExists(Participant participant) {
    return _participants.any((element) {
      return element.firebaseUserUid == participant.firebaseUserUid;
    });
  }

  void removeParticipant(Participant participant) {
    _participants.remove(participant);
    validateParticipants(_participants);
    notifyListeners();
  }

  void setParticipants(List<Participant> participants) {
    _participants = participants;
    validateParticipants(_participants);
    notifyListeners();
  }

  String? validateEventName(String? eventName) {
    String? validationMessage = bill_validator.validateBillEventName(eventName);
    if (validationMessage == null) {
      _isEventNameValid = true;
      notifyListeners();
    } else {
      _isEventNameValid = false;
      notifyListeners();
    }
    return validationMessage;
  }

  void validateParticipants(List<Participant> participants) {
    if (participants.isEmpty) {
      _isParticipantsValid = false;
      _participantsValidationMessage = 'É obrigatório informar ao menos um participante';
      notifyListeners();
    } else {
      _isParticipantsValid = true;
      _participantsValidationMessage = null;
      notifyListeners();
    }
  }

  bool isStepValidToAdvance(BillCreationStep billCreationStep) {
    switch (billCreationStep) {
      case BillCreationStep.eventNameQuestion:
        return isEventNameValid;
      case BillCreationStep.participantsQuestion:
        return isParticipantsValid;
      default:
        return false;
    }
  }
}
