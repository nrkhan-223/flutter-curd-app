import 'package:curd_operatio/api/Api.dart';
import 'package:curd_operatio/screens/widget/input_field.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/task_model.dart';

class EditPage extends StatefulWidget {
  final Task task;
  const EditPage({super.key, required this.task});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
   final TextEditingController _titleController = TextEditingController();
   final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleController.text=widget.task.title;
    _descController.text=widget.task.description;
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        centerTitle: true,
        title: const Text("Edit Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              15.heightBox,
              TextInputField(
                max: false,
                hint: "Title",
                title: "Edit Title",
                controller: _titleController,
              ),
              15.heightBox,
              TextInputField(
                max: true,
                hint: "Description",
                title: "Description",
                controller: _descController,
              ),

              20.heightBox,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, elevation: 2),
                  onPressed: () {

                    Api.editTask(widget.task.id, _titleController.text, _descController.text,context);
                  },
                  child: "Update Task".text.black.semiBold.size(18).make()),
            ],
          ),
        ),
      ),
    );
  }
}
