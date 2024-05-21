import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiHelper {
  static CustomizeTextField(
      TextEditingController controller, String text, bool ishide, Icon icon) {
    return TextField(
      controller: controller,
      obscureText: ishide,
      decoration: InputDecoration(
          hintText: text,
          suffixIcon: icon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }

  static CustomizedButton(VoidCallback voidCallBack, String text) {
    return SizedBox(
      height: 60,
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(
            255,
            69,
            29,
            138,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          voidCallBack();
        },
      ),
    );
  }

  static CustomizeAlertBox(BuildContext context, String text) {
    return AlertDialog(
      title: Text(text),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"))
      ],
    );
  }
}
