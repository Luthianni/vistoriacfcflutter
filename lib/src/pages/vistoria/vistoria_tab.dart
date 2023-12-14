import 'package:flutter/material.dart';

class VistoriaTab extends StatefulWidget {
  const VistoriaTab({Key? key}) : super(key: key);

  @override
  State<VistoriaTab> createState() => _VistoriaTab();
}

class _VistoriaTab extends State<VistoriaTab> {
  final List<String> salas = [
    // 'recepção',
    // 'Diretor de Ensino e Geral',
    // 'secretaria',
    // 'instrutores'
  ];
  final List<String> banheiros = ['Masculino', 'Feminino'];
  final List<String> treinamento = [
    // 'Televisão',
    // 'DVD',
    // 'retroprojetor',
    // 'quadro branco 2m X 1,20m',
    // 'tela p/ projeção',
    // 'Acervo bibliográfico sobre trânsito(CTB)',
    // 'Manuais e apostilas para os candidatos e condutores',
  ];
  final List<String> deficientes = [
    // 'Rampa de acesso para deficientes físicos',
    // 'Banheiro deficiente físico'
  ];
  final List<String> suporte = [
    // 'Bebedouro'
  ];

  List<bool> selectedSalas = List.generate(4, (index) => false);
  List<bool> selectedBanheiros = List.generate(2, (index) => false);
  List<bool> selectedTreinamento = List.generate(7, (index) => false);
  List<bool> selectedDeficientes = List.generate(2, (index) => false);
  List<bool> selectedSuporte = List.generate(1, (index) => false);

  Widget buildCard(List<String> items, String cardTitle,
      List<bool> selectedValues, void Function(int, bool) onChanged) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              cardTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            color: Colors.green.shade300,
          ),
          Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return CheckboxListTile(
                title: Text(item),
                value: selectedValues[index],
                onChanged: (value) {
                  onChanged(index, value ?? false);
                },
                activeColor: Colors.green,
                controlAffinity: ListTileControlAffinity.leading,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Vistoria',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          buildCard(salas, 'Salas', selectedSalas, (int index, bool value) {
            setState(() {
              selectedSalas[index] = value;
            });
          }),
          buildCard(banheiros, 'Banheiros', selectedBanheiros,
              (int index, bool value) {
            setState(() {
              selectedBanheiros[index] = value;
            });
          }),
          buildCard(treinamento, 'Equipamentos', selectedTreinamento,
              (int index, bool value) {
            setState(() {
              selectedTreinamento[index] = value;
            });
          }),
          buildCard(deficientes, 'PCD', selectedDeficientes,
              (int index, bool value) {
            setState(() {
              selectedDeficientes[index] = value;
            });
          }),
          buildCard(suporte, 'Suporte', selectedSuporte,
              (int index, bool value) {
            setState(() {
              selectedSuporte[index] = value;
            });
          }),
        ],
      ),
    );
  }
}
