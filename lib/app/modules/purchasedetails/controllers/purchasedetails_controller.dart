import 'package:get/get.dart';

class PurchasedetailsController extends GetxController {
  final List<String> paymentMethods = ["Card", "Bkash", "Nogod", "Rocket"];

  final RxString selectedMethod = "Card".obs;

  void selectMethod(String method) {
    selectedMethod.value = method;
  }
}
