import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_cfc/src/models/vistoria_model.dart';
import 'package:vistoria_cfc/src/pages/vistoria/vistoria_tab.dart';
import 'package:vistoria_cfc/src/services/utils_services.dart';

class VistoriaScreen extends StatefulWidget {
  VistoriaScreen({
    Key? key,
    VistoriaModel? vistoria,
  }) : super(key: key);

  final VistoriaModel vistoria = Get.arguments.isNullOrBlank;

  @override
  State<VistoriaScreen> createState() => _VistoriaScreenState();
}

class _VistoriaScreenState extends State<VistoriaScreen> {
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Hero(
                  tag: widget.vistoria.imgUrl ?? '',
                  child: Image.asset(
                    widget.vistoria.imgUrl ?? '',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.vistoria.cfcName ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SingleChildScrollView(
                                child: Text(
                                  "CNPJ :"
                                  '${widget.vistoria.cnpj ?? 'N/A'}',
                                  style: const TextStyle(
                                      height: 1.5, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "Endereço :"
                                '${widget.vistoria.logradouro}',
                                style: const TextStyle(
                                    height: 1.5, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Bairro :"
                                '${widget.vistoria.bairro}',
                                style: const TextStyle(
                                    height: 1.5, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Cidade :"
                                '${widget.vistoria.cidade}',
                                style: const TextStyle(
                                    height: 1.5, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Estado :"
                                '${widget.vistoria.estado}',
                                style: const TextStyle(
                                    height: 1.5, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Cep :"
                                '${widget.vistoria.cep}',
                                style: const TextStyle(
                                    height: 1.5, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (c) {
                                  return const VistoriaTab();
                                },
                              ),
                            );
                          },
                          label: const Text(
                            'Iniciar Vistoria',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: const Icon(
                            Icons.add_comment_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 10,
            top: 10,
            child: SafeArea(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
