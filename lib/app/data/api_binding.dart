import 'package:get/get.dart';
import 'package:meli_driweather/app/data/api_service.dart';

class ApiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Apiservices>(Apiservices());
  }
}
