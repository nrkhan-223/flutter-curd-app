
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TextInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final bool max;

  const TextInputField(
      {super.key,
      this.controller,
      required this.max,
      required this.hint,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          5.heightBox,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.2),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                      autofocus: false,
                      maxLines: max ? 4 : 1,
                      controller: controller,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
