import 'dart:convert';

import 'package:curd_operatio/api/Api.dart';
import 'package:curd_operatio/screens/widget/input_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

import '../models/CreatTask_model.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        centerTitle: true,
        title: const Text("Add Screen"),
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
                title: "Add title",
                controller: _titleController,
              ),
              15.heightBox,
              TextInputField(
                max: true,
                hint: "Description",
                title: "Description",
                controller: _descController,
              ),

              15.heightBox,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, elevation: 2),
                  onPressed: () {
                    Api.submitData(_titleController.text,_descController.text, context);
                  },
                  child: "Add Task".text.black.semiBold.size(18).make()),
            ],
          ),
        ),
      ),
    );
  }


}
