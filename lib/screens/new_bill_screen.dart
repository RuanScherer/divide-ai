import 'package:divide_ai/enums/bill_creation_step_enum.dart';
import 'package:divide_ai/globals/globals.dart';
import 'package:divide_ai/models/participant.dart';
import 'package:divide_ai/providers/bill_provider.dart';
import 'package:divide_ai/widgets/default_button.dart';
import 'package:divide_ai/widgets/default_text_form_field.dart';
import 'package:divide_ai/widgets/delegates/participants_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewBillScreen extends StatefulWidget {
  const NewBillScreen({Key? key}) : super(key: key);

  @override
  State<NewBillScreen> createState() => _NewBillScreenState();
}

class _NewBillScreenState extends State<NewBillScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BillCreationStep _step = BillCreationStep.eventNameQuestion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Align(
            alignment: Alignment.center,
            child: Text(
              (_step.index + 1).toString().padLeft(2, '0'),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '-',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              BillCreationStep.values.length.toString().padLeft(2, '0'),
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (_) => BillProvider(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(22),
              child: Form(
                key: _formKey,
                child: Consumer<BillProvider>(
                  builder: (context, billProvider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _buildCurrentQuestion(context, billProvider),
                    );
                  },
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Colors.grey[300]!,
                    width: 2,
                  ),
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: _onBackButtonPressed,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 15,
                          ),
                          child: Text(
                            'VOLTAR',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 2,
                      color: Colors.grey[300],
                    ),
                    Expanded(
                      flex: 1,
                      child: Consumer<BillProvider>(
                        builder: (context, billProvider, child) {
                          return InkWell(
                            onTap: billProvider.isStepValidToAdvance(_step)
                                ? () => _onContinueButtonPressed(billProvider)
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 15,
                              ),
                              child: Text(
                                'CONTINUAR',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      billProvider.isStepValidToAdvance(_step)
                                          ? null
                                          : Colors.grey[500],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCurrentQuestion(
    BuildContext context,
    BillProvider billProvider,
  ) {
    switch (_step) {
      case BillCreationStep.eventNameQuestion:
        return _buildEventNameQuestion(context, billProvider);
      case BillCreationStep.participantsQuestion:
        return _buildParticipantsQuestion(context, billProvider);
      default:
        return [];
    }
  }

  List<Widget> _buildEventNameQuestion(
    BuildContext context,
    BillProvider billProvider,
  ) {
    return [
      const Text(
        'Qual o nome',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      const Text(
        'do evento?',
        style: TextStyle(fontSize: 30, height: 1.3),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 30,
      ),
      DefaultTextFormField(
        validator: billProvider.validateEventName,
        onChanged: (text) {
          billProvider.setEventName(text);
          _formKey.currentState?.validate();
        },
        textCapitalization: TextCapitalization.sentences,
        labelText: 'Nome do evento',
        hintText: 'Ex.: Churrasco',
        value: billProvider.eventName ?? '',
      ),
    ];
  }

  List<Widget> _buildParticipantsQuestion(
    BuildContext context,
    BillProvider billProvider,
  ) {
    return [
      const Text(
        'Com quem',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      const Text(
        'você quer dividir?',
        style: TextStyle(fontSize: 30, height: 1.3),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 30,
      ),
      DefaultButton(
        onPressed: () async {
          String? participantJSONString = await showSearch(
            context: context,
            delegate: ParticipantsDelegate(),
          );

          if (participantJSONString != null &&
              participantJSONString.isNotEmpty) {
            billProvider.addParticipant(
              Participant.fromJSONString(participantJSONString),
            );
          }
        },
        backgroundColor: Colors.grey[200],
        overlayColor: Colors.grey[300]!,
        text: 'Adicionar participante',
        leading: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      SingleChildScrollView(
        child: Wrap(
          spacing: 6,
          alignment: WrapAlignment.center,
          children: billProvider.participants.map((participant) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.grey[500],
                    backgroundImage: participant.avatarUrl != null
                        ? NetworkImage(participant.avatarUrl!)
                        : null,
                  ),
                  label: Text(participant.name!),
                  labelStyle: const TextStyle(fontSize: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(.15),
                  deleteIcon: const Icon(
                    Icons.close,
                    size: 18,
                  ),
                  onDeleted: () => billProvider.removeParticipant(participant),
                  deleteButtonTooltipMessage: 'Remover',
                ),
              ],
            );
          }).toList(),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ];
  }

  void _onBackButtonPressed() {
    bool isFirstStep = _step.index == 0;
    if (isFirstStep) {
      navigatorKey.currentState?.pop();
    } else {
      _goToPreviousStep();
    }
  }

  void _goToPreviousStep() {
    setState(() {
      _step = BillCreationStep.values[_step.index - 1];
    });
  }

  void _onContinueButtonPressed(BillProvider billProvider) {
    bool isLastStep = _step.index == BillCreationStep.values.length - 1;
    if (!isLastStep) {
      setState(() {
        _step = BillCreationStep.values[_step.index + 1];
      });
    } else {
      // billProvider.saveBill();
    }
  }
}
