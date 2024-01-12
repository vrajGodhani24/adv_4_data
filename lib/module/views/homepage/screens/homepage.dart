import 'package:adv_4_database/module/helper/database_helper.dart';
import 'package:adv_4_database/module/views/homepage/controller/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.put(HomePageController());

    String name = "";
    int age = 0;
    String contact = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: GetBuilder<HomePageController>(builder: (controller) {
        return Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Search",
                  ),
                  onChanged: (val) {
                    homePageController.searchName(val);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: (homePageController.fetchStudentData == [])
                  ? const Text("No data")
                  : ListView(
                      children: (homePageController
                              .fetchSearchStudentData.isNotEmpty)
                          ? homePageController.fetchSearchStudentData
                              .map(
                                (e) => (e == null)
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: Card(
                                          elevation: 3,
                                          child: ListTile(
                                            onTap: () {},
                                            leading:
                                                const FlutterLogo(size: 60),
                                            title: Text(e.name),
                                            subtitle: Text(e.contact),
                                            trailing: Text("${e.age}"),
                                          ),
                                        ),
                                      ),
                              )
                              .toList()
                          : homePageController.fetchStudentData
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Card(
                                    elevation: 3,
                                    child: ListTile(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              padding: const EdgeInsets.all(20),
                                              height: 400,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  topRight: Radius.circular(25),
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Update Student Details",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  TextField(
                                                    onChanged: (val) {
                                                      name = val;
                                                    },
                                                    decoration: InputDecoration(
                                                      border:
                                                          const OutlineInputBorder(),
                                                      hintText: e.name,
                                                    ),
                                                  ),
                                                  TextField(
                                                    onChanged: (val) {
                                                      age = int.parse(val);
                                                    },
                                                    decoration: InputDecoration(
                                                      border:
                                                          const OutlineInputBorder(),
                                                      hintText: "${e.age}",
                                                    ),
                                                  ),
                                                  TextField(
                                                    onChanged: (val) {
                                                      contact = val;
                                                    },
                                                    decoration: InputDecoration(
                                                      border:
                                                          const OutlineInputBorder(),
                                                      hintText: e.contact,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      OutlinedButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: const Text(
                                                            "Cancel"),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          await DataBaseHelper
                                                              .databaseHelper
                                                              .updateData(
                                                                  id: e.id,
                                                                  name: name,
                                                                  age: age,
                                                                  contact:
                                                                      contact)
                                                              .then((value) {
                                                            Get.back();
                                                            homePageController
                                                                .onInit();
                                                          });
                                                        },
                                                        child:
                                                            const Text("Save"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      leading: const FlutterLogo(size: 60),
                                      title: Text(e.name),
                                      subtitle: Text(e.contact),
                                      trailing: Text("${e.age}"),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Enter Student's Data"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Enter your name",
                      ),
                      onChanged: (val) {
                        name = val;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Enter your age",
                      ),
                      onChanged: (val) {
                        age = int.parse(val);
                      },
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Enter your contact",
                      ),
                      onChanged: (val) {
                        contact = val;
                      },
                    ),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          DataBaseHelper.databaseHelper
                              .insertData(
                                  name: name, age: age, contact: contact)
                              .then((value) {
                            Get.back();
                          });
                          homePageController.onInit();
                        },
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
