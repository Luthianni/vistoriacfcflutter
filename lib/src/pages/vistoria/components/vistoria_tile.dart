import 'package:flutter/material.dart';
import 'package:vistoria_cfc/src/models/vistoria_model.dart';
import 'package:vistoria_cfc/src/pages/vistoria/view/vistoria_tab.dart';

class VistoriaTile extends StatelessWidget {
  final VistoriaModel vistoria;

  const VistoriaTile({
    super.key,
    required this.vistoria,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (c) {
              return const VistoriaTab();
            }));
          },
          child: SizedBox(
            height: 600,
            child: Card(
              elevation: 1,
              shadowColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${vistoria.cfcName}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${vistoria.cnpj}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
