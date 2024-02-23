import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import '../models/CreatTask_model.dart';
import '../models/task_model.dart';

class Api {
  static Future<List<Task>> getItem(context) async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=20';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body) as Map;
    final result = json['items'] as List;
    final item = result.map((e) => Task.fromJson(e)).toList();
    if (response.statusCode == 200) {
      log(response.statusCode.toString());
      log(response.body.toString());
      return item;
    } else {
      var snackBar = SnackBar(
        content: 'Failed'.text.black.semiBold.make(),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return [];
    }
  }

  static void submitData(String title, String desc, context) async {
    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final body =
        CreateTask(title: title, description: desc, isCompleted: false);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      var snackBar = SnackBar(
        content: 'success'.text.black.semiBold.make(),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      VxToast.show(context, msg: "Error");
      var snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: 'Failed'.text.white.semiBold.make(),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  static Future<void> deleteById(id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      log("delete success");
    } else {
      log("delete flied");
    }
  }

  static void editTask(id,String title, String desc, context) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final body =
    CreateTask(title: title, description: desc, isCompleted: false);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var snackBar = SnackBar(
        content: 'success'.text.black.semiBold.make(),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      VxToast.show(context, msg: "Error");
      var snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: 'Failed'.text.white.semiBold.make(),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
