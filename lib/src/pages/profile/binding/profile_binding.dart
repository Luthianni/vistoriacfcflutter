
import 'package:get/get.dart';
import 'package:vistoria_cfc/src/pages/profile/controller/profile_controller.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}