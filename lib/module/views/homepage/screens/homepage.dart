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
