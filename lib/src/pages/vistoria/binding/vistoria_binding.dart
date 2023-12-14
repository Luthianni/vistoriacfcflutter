import 'package:get/get.dart';
import 'package:vistoria_cfc/src/pages/vistoria/controller/vistoria_controller.dart';

class VistoriaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VistoriaController());
  }
}
