import 'package:get/get.dart';
import 'package:vistoria_cfc/src/pages/cfc/controller/cfc_controller.dart';

class CfcBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CfcController());
  }
}
