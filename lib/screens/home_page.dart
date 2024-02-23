import 'package:curd_operatio/api/Api.dart';
import 'package:curd_operatio/screens/add_page.dart';
import 'package:curd_operatio/screens/edit_page.dart';
import 'package:curd_operatio/screens/widget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> task = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        centerTitle: true,
        title: const Text("CURD APP"),
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        clipBehavior: Clip.antiAlias,
        onPressed: () {
          navigate();
        },
        child: "add text".text.make(),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: getItems,
          child: Visibility(
            visible: task.isNotEmpty,
            replacement: Center(
              child: "No TODO Item".text.white.semiBold.size(20).make(),
            ),
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                itemCount: task.length,
                itemBuilder: (context, index) {
                  final tasks = task[index];
                  var title = tasks.title;
                  return Card(
                    color: const Color.fromARGB(255, 43, 43, 43),
                    shape: const Border.symmetric(vertical: BorderSide.none),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black87,
                        child: '${index + 1}'.text.size(20).make(),
                      ),
                      title: title.text.make(),
                      subtitle:
                          tasks.description.text.size(13).maxLines(2).make(),
                      trailing: const Icon(Icons.more_horiz).onTap(() {
                        _showBottomSheet(context, tasks);
                      }),
                    ),
                  );
                }),
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> getItems() async {
    isLoading = true;
    final response = await Api.getItem(context);
    setState(() {
      task = response;
      isLoading = false;
    });
  }

  Future<void> deleteItem(id) async {
    await Api.deleteById(id);
    final filterItem = task.where((element) => element.id != id).toList();
    setState(() {
      task = filterItem;
    });
  }

  Future<void> navigate() async {
    await Get.to(() => const AddPage());
    setState(() {
      isLoading = true;
    });
    getItems();
  }

  Future<void> navigate2(task) async {
    await Get.to(() => EditPage(task: task));
    setState(() {
      isLoading = true;
    });
    getItems();
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      width: context.screenWidth,
      padding: const EdgeInsets.only(top: 2),
      height: task.isCompleted == true
          ? context.screenHeight * 0.25
          : context.screenHeight * 0.40,
      color: Colors.grey,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: CupertinoColors.systemGrey5,
            ),
          ),
          25.heightBox,
          Visibility(
            visible: task.isCompleted == true ? false : true,
            child: commonButton(
              context: context,
              onPress: () {
                Get.back();
              },
              color: Colors.blue,
              title: "Task Completed",
              textColor: Colors.white,
            ),
          ),
          10.heightBox,
          Visibility(
            visible: task.isCompleted == true ? false : true,
            child: commonButton(
              context: context,
              onPress: () {
                navigate2(task);
              },
              color: Colors.green,
              title: "Edit Task",
              textColor: Colors.white,
            ),
          ),
          10.heightBox,
          commonButton(
            context: context,
            onPress: () {
              deleteItem(task.id);
              Get.back();
              VxToast.show(context, msg: "Task hasten deleted");
            },
            color: Colors.red,
            title: "Delete Task",
            textColor: Colors.white,
          ),
          const Spacer(),
          commonButton(
            context: context,
            onPress: () {
              Get.back();
            },
            color: Colors.black87,
            title: "Close",
            textColor: Colors.red,
          ),
          20.heightBox
        ],
      ),
    ));
  }
}
