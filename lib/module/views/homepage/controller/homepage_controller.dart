import 'package:adv_4_database/module/helper/database_helper.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    await DataBaseHelper.databaseHelper.initDB();
  }
}
