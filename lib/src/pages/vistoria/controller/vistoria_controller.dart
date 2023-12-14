import 'package:get/get.dart';
import 'package:vistoria_cfc/src/models/vistoria_model.dart';
import 'package:vistoria_cfc/src/pages/vistoria/repository/vistoria_repository.dart';
import 'package:vistoria_cfc/src/services/utils_services.dart';

class VistoriaController extends GetxController {
  final vistoriaRepository = VistoriaRepository();
  final utilsService = UtilsServices();
}

bool isVistoriaLoading = false;
bool isOrderLoading = true;

List<VistoriaModel>? allVistorias = [];
VistoriaModel? currentVistoria;
