import 'package:adv_4_database/module/helper/database_helper.dart';
import 'package:adv_4_database/module/views/homepage/model/student.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  List<Student> fetchStudentData = [];
  List<Student?> fetchSearchStudentData = [];
  String searching = "";

  @override
  void onInit() async {
    super.onInit();

    await DataBaseHelper.databaseHelper.initDB();

    List data = await DataBaseHelper.databaseHelper.fetchAllData();

    fetchStudentData = data.map((e) {
      return Student(
          id: e['id'], name: e['name'], age: e['age'], contact: e['contact']);
    }).toList();

    update();
  }

  void searchName(String searchedText) {
    fetchSearchStudentData = fetchStudentData.map((e) {
      if (e.name.toLowerCase().contains(searchedText)) {
        return e;
      }
    }).toList();
    update();
  }
}
