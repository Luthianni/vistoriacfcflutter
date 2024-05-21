import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_cfc/src/models/vistoria_model.dart';
import 'package:vistoria_cfc/src/pages/profile/controller/profile_controller.dart';
import 'package:vistoria_cfc/src/pages/vistoria/components/vistoria_tile.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  Future<List<VistoriaModel>> fetchData() async {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    String? nomeUsuario = profileController.profile.nome;
    List<String> partesNome = nomeUsuario?.split(' ') ?? [];
    String primeiroNome = partesNome.isNotEmpty ? partesNome[0] : '';
    String ultimoNome = partesNome.length > 1 ? partesNome[1] : '';

    String nomeFormatado =
        '${StringExtension.capitalize(primeiroNome)} ${StringExtension.capitalize(ultimoNome)}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 106, 193, 145),
        title: Text(
          'Olá, $nomeFormatado!',
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1.0),
            fontSize: 14,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<VistoriaModel>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Erro ao carregar vistorias'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('Nenhuma vistoria encontrada'));
                } else {
                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      childAspectRatio: 16 / 6.5,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      return VistoriaTile(
                        vistoria: snapshot.data![index],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  static String capitalize(String text) {
    return text.isNotEmpty
        ? text[0].toUpperCase() + text.substring(1).toLowerCase()
        : '';
  }
}
