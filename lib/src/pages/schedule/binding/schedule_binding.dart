
import 'package:get/get.dart';
import 'package:vistoria_cfc/src/pages/schedule/controller/schedule_controller.dart';

class ScheduleBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ScheduleController());
  }
}