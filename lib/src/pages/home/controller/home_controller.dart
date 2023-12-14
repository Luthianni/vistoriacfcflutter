import 'package:get/get.dart';
import 'package:vistoria_cfc/src/models/vistoria_model.dart';
import 'package:vistoria_cfc/src/pages/home/repository/home_repository.dart';
import 'package:vistoria_cfc/src/services/utils_services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final homeRepository = HomeRepository();
  final utilsService = UtilsServices();
}

bool isVistoriaLoading = false;
bool isOrderLoading = true;

List<VistoriaModel> allVistorias = [];
VistoriaModel? currentVistoria;
