import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_cfc/src/pages/auth/controller/auth_controller.dart';
import 'package:vistoria_cfc/src/pages/profile/controller/profile_controller.dart';
import 'package:brasil_fields/brasil_fields.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final profileController = Get.find<ProfileController>();
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    profileController.profileId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil do usuário',
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1.0),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(Icons.logout),
            color: const Color.fromRGBO(255, 255, 255, 1.0),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 106, 193, 145),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      body: Stack(
        alignment: Alignment.topCenter, // Alinha a Stack no topo do corpo
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 05.0), // Espaço entre a AppBar e o primeiro Container
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(30.0),
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.height / 2.3,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Divider(
            color: Colors.transparent,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200.0, left: 50.0),
                child: Text(
                  " ${profileController.profile.nome ?? 'Nome não encontrado !!'}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(9, 9, 9, 1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 200.0),
                child: Text(
                  "CPF: ${UtilBrasilFields.obterCpf(profileController.profile.cpf ?? 'Não foi posivel encontrar o CPF !!')}",
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(9, 9, 9, 1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 200.0),
                child: Text(
                  "Matrícula: ${profileController.profile.matricula ?? 'Não foi posivel encontrar a Matricula !!'}",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(9, 9, 9, 1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 100.0),
                child: Text(
                  "Telefone: ${UtilBrasilFields.obterTelefone(profileController.profile.telefone ?? 'Telefone não encontrado!!')}",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(9, 9, 9, 1),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0),
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width / 4,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1.0),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 25.0,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: const Image(image: AssetImage('assets/avatar.png')),
            ),
          ),
        ],
      ),
    );
  }
}
