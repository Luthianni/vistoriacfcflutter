import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.height / 2.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Column(
                      children: [
                        //const FlutterLogo(size: 100),
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Nome: Luthianni Alves",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.height / 1.5,
                            child: const Text(
                              "CRT:",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          // child: Divider(color: Colors.red),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: const Text(
                              "Setor:",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: const Text(
                              "Texto 04",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class _ProfileTabState extends State<ProfileTab> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Perfil do usuário'),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.logout,
//             ),
//           ),
//         ],
//       ),
//       body: ListView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
//         children: [
//           const CircleAvatar(
//             radius: 0,
//             backgroundImage: AssetImage('assets/logo.png'),
//           ),
//           const SizedBox(height: 20),
//           //Email
//           CustomTextField(
//             readOnly: true,
//             initialValue: appData.user.email,
//             icon: Icons.email,
//             label: 'Email',
//           ),
//           //Nome
//           CustomTextField(
//             readOnly: true,
//             initialValue: appData.user.name,
//             icon: Icons.person,
//             label: 'Nome',
//           ),
//           //Celular
//           CustomTextField(
//             readOnly: true,
//             initialValue: appData.user.phone,
//             icon: Icons.phone,
//             label: 'Celular',
//           ),
//           //CPF
//           CustomTextField(
//             readOnly: true,
//             initialValue: appData.user.cpf,
//             icon: Icons.file_copy,
//             label: 'CPF',
//             isSecret: true,
//           ),

//           // Botão atualizar senha
//           SizedBox(
//             height: 50,
//             child: OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                   side: const BorderSide(
//                     color: Colors.green,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   )),
//               onPressed: () {
//                 updatePassword();
//               },
//               child: const Text('Atualizar a Senha'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<bool?> updatePassword() {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     //Titulo
//                     const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                       child: Text(
//                         'Atualização de senha',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     //Senha atual
//                     const CustomTextField(
//                       isSecret: true,
//                       icon: Icons.lock,
//                       label: 'Senha atual',
//                       readOnly: false,
//                       initialValue: 'hum',
//                     ),
//                     //Nova senha
//                     const CustomTextField(
//                       isSecret: true,
//                       icon: Icons.lock_outline,
//                       label: 'Nova senha',
//                       readOnly: false,
//                       initialValue: 'doistres',
//                     ),
//                     // Confirmação nova senha
//                     const CustomTextField(
//                       isSecret: true,
//                       icon: Icons.lock_outline,
//                       label: 'Confirmar nova senha',
//                       readOnly: false,
//                       initialValue: 'doistres',
//                     ),

//                     // Botão de confirmação
//                     SizedBox(
//                       height: 45,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                         onPressed: () {},
//                         child: const Text('Atualizar'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: 5,
//                 right: 5,
//                 child: IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: const Icon(Icons.close),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
