import 'package:flutter/material.dart';

class NewBillScreen extends StatelessWidget {
  const NewBillScreen({Key? key}) : super(key: key);

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
              '01',
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
              '03',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildParticipantsQuestion(context),
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
                      onTap: () {
                        Navigator.of(context).pop();
                      },
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
                    child: InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 15,
                        ),
                        child: Text(
                          'CONTINUAR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildEventNameQuestion(BuildContext context) {
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
      TextFormField(
        textAlign: TextAlign.center,
        autofocus: true,
        cursorColor: Theme.of(context).primaryColor,
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: 'Ex.: Churrasco',
          hintStyle: TextStyle(
              color: Colors.grey[500]
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildParticipantsQuestion(BuildContext context) {
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
      TextFormField(
        textAlign: TextAlign.center,
        autofocus: true,
        cursorColor: Theme.of(context).primaryColor,
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: 'Digite um nome',
          hintStyle: TextStyle(
              color: Colors.grey[500]
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
        ),
      ),
      const SizedBox(height: 30,),
      const Text(
        'RECENTES',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      // ListView.builder(
      //   itemCount: 1,
      //   itemBuilder: (context, index) {
      //     return Text('incrivel');
      //   },
      // ),
    ];
  }
}
