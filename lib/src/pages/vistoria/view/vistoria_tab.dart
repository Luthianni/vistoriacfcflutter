import 'package:flutter/material.dart';

class VistoriaTab extends StatefulWidget {
  const VistoriaTab({Key? key}) : super(key: key);

  @override
  State<VistoriaTab> createState() => _VistoriaTab();
}

class _VistoriaTab extends State<VistoriaTab> {
  int _activeStepIndex = 0;

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text(
            'Salas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 158, 224, 160),
            ),
          ),
          content: const Card(
            color: Color.fromARGB(255, 158, 224, 160),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Salas',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1.0),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Divider(color: Colors.white, height: 25),
                  Row(
                    children: [],
                  )
                  // Adicione seus widgets personalizados aqui
                ],
              ),
            ),
          ),
        ),
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text(
            'Banheiros',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 158, 224, 160),
            ),
          ),
          content: const Card(
            color: Color.fromRGBO(38, 187, 55, 1.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Conteúdo personalizado para banheiros',
                    style: TextStyle(color: Colors.white),
                  ),
                  // Adicione seus widgets personalizados aqui
                ],
              ),
            ),
          ),
        ),
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Equipamentos'),
          content: const Card(
            color: Color.fromARGB(255, 158, 224, 160),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Conteúdo personalizado para Equipamentos'),
                  // Adicione seus widgets personalizados aqui
                ],
              ),
            ),
          ),
        ),
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('PCD'),
          content: const Card(
            color: Color.fromARGB(255, 158, 224, 160),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Conteúdo personalizado para PCD'),
                  // Adicione seus widgets personalizados aqui
                ],
              ),
            ),
          ),
        ),
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Suporte'),
          content: const Card(
            color: Color.fromARGB(255, 158, 224, 160),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Conteúdo personalizado para Suporte'),
                  // Adicione seus widgets personalizados aqui
                ],
              ),
            ),
          ),
        ),
        Step(
          state: _activeStepIndex <= 5 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 5,
          title: const Text('Concluir'),
          content: const Center(
            child: Text('Concluir'),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final List<Step> steps = stepList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 171, 245, 171),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Vistoria',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(255, 255, 255, 1.0),
          ),
        ),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _activeStepIndex,
        steps: steps,
        onStepContinue: () {
          if (_activeStepIndex < (steps.length - 1)) {
            _activeStepIndex += 1;
          }
          setState(() {});
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }
          _activeStepIndex -= 1;
          setState(() {});
        },
        onStepTapped: (step) {
          setState(() {
            _activeStepIndex = step;
          });
        },
      ),
    );
  }
}
