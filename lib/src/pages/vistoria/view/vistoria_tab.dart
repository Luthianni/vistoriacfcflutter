import 'package:flutter/material.dart';

class VistoriaTab extends StatefulWidget {
  const VistoriaTab({Key? key}) : super(key: key);

  @override
  State<VistoriaTab> createState() => _VistoriaTabState();
}

class _VistoriaTabState extends State<VistoriaTab> {
  int _activeStepIndex = 0;
  final Color customGreenColor = const Color.fromARGB(255, 106, 193, 145);

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: Text(
            'Salas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: customGreenColor,
            ),
          ),
          content: Card(
            color: customGreenColor,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Salas',
                    style: TextStyle(
                      color: Colors.white,
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
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: Text(
            'Banheiros',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: customGreenColor,
            ),
          ),
          content: Card(
            color: customGreenColor,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Banheiros',
                    style: TextStyle(
                      color: Colors.white,
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
          state: _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: Text(
            'Equipamentos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: customGreenColor,
            ),
          ),
          content: Card(
            color: customGreenColor,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Equipamentos',
                    style: TextStyle(
                      color: Colors.white,
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
          state: _activeStepIndex <= 3 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 3,
          title: Text(
            'PCD',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: customGreenColor,
            ),
          ),
          content: Card(
            color: customGreenColor,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'PCD',
                    style: TextStyle(
                      color: Colors.white,
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
          state: _activeStepIndex <= 4 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 4,
          title: Text(
            'Suporte',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: customGreenColor,
            ),
          ),
          content: Card(
            color: customGreenColor,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Suporte',
                    style: TextStyle(
                      color: Colors.white,
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
          state: _activeStepIndex <= 5 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 5,
          title: Text(
            'Concluir',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: customGreenColor,
            ),
          ),
          content: const Center(
            child: Text(''),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final List<Step> steps = stepList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customGreenColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Vistoria',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(primary: customGreenColor),
        ),
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _activeStepIndex,
          steps: steps,
          onStepContinue: () {
            if (_activeStepIndex < (steps.length - 1)) {
              setState(() {
                _activeStepIndex += 1;
              });
            }
          },
          onStepCancel: () {
            if (_activeStepIndex > 0) {
              setState(() {
                _activeStepIndex -= 1;
              });
            }
          },
          onStepTapped: (step) {
            setState(() {
              _activeStepIndex = step;
            });
          },
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            return Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: controls.onStepContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customGreenColor,
                  ),
                  child: const Text(
                    'CONCLUIR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: controls.onStepCancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customGreenColor,
                  ),
                  child: const Text(
                    'CANCELAR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
