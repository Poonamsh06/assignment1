import 'package:flutter/material.dart';

class UiHelper {
  static CustomizeTextField(
      TextEditingController controller, String text, bool ishide, Icon icon) {
    return TextField(
      controller: controller,
      obscureText: ishide,
      decoration: InputDecoration(
          hintText: text,
          prefixIcon: icon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
    );
  }

  static CustomizedButton(VoidCallback voidCallBack, String text) {
    return SizedBox(
      height: 60,
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        child: Text(text),
        onPressed: () {
          voidCallBack();
        },
      ),
    );
  }

  static CustomizeAlertBox(BuildContext context, String text) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: AlertDialog(
        title: Text(text),
      ),
    );
  }
}
