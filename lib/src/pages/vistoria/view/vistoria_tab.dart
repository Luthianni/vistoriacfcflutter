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
          content: GestureDetector(
            onTap: () => _showModal('Salas'),
            child: Card(
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
                  ],
                ),
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
          content: GestureDetector(
            onTap: () => _showModal('Banheiros'),
            child: Card(
              color: customGreenColor,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Conteúdo personalizado para banheiros',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
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
          content: GestureDetector(
            onTap: () => _showModal('Equipamentos'),
            child: Card(
              color: customGreenColor,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Conteúdo personalizado para Equipamentos',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
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
          content: GestureDetector(
            onTap: () => _showModal('PCD'),
            child: Card(
              color: customGreenColor,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Conteúdo personalizado para PCD',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
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
          content: GestureDetector(
            onTap: () => _showModal('Suporte'),
            child: Card(
              color: customGreenColor,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Conteúdo personalizado para Suporte',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
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
            child: Text('Concluir'),
          ),
        ),
      ];

  void _showModal(String stepName) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Selecione os itens para $stepName',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              // Aqui você pode adicionar uma lista de itens para selecionar
              ListView(
                shrinkWrap: true,
                children: const [
                  ListTile(
                    title: Text('Item 1'),
                  ),
                  ListTile(
                    title: Text('Item 2'),
                  ),
                  ListTile(
                    title: Text('Item 3'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: customGreenColor,
                ),
                child: const Text(
                  'FECHAR',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: controls.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: customGreenColor,
                    ),
                    child: const Text(
                      'CONTINUAR',
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
              ),
            );
          },
        ),
      ),
    );
  }
}
