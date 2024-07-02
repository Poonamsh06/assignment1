import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UiHelper {
  static customizeText(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
            letterSpacing: 0.07,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color.fromRGBO(0, 0, 0, 1)),
      ),
    );
  }

  static customizeTextSmall(String text) {
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
          letterSpacing: 0.07,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          color: Color.fromRGBO(106, 108, 123, 1),
        ));
  }

  static customizeTextCountry(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromARGB(45, 17, 19, 1),
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w700,
        fontSize: 16.sp,
      ),
    );
  }

  static customizeTextButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Color.fromRGBO(47, 48, 55, 1),
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  static customizeTextCB(
      {required String text,
      required double width,
      required double height,
      required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
          ),
        ),
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Color.fromRGBO(46, 59, 98, 1), // Transparent blue
            border: Border.all(width: 1, color: Color.fromRGBO(47, 48, 55, 1))),
      ),
    );
  }

  static customizeProfileContainer(
      {required Image image,
      required Image image1,
      required Image image2,
      required String text,
      required String text1,
      required VoidCallback onPressed,
      required bool isFilled}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 328.w,
        height: 89.h,
        child: Row(
          children: [
            SizedBox(
              width: 16.w,
            ),
            // Center(child:
            //     // Icon(
            //     //   isFilled ? Icons.circle : Icons.circle_outlined,
            //     //   size: isFilled ? 16 : 24,
            //     //   color: isFilled ? Color.fromRGBO(46, 59, 98, 1) : null,
            //     // ),
            //     ),
            SizedBox(
              width: 8.w,
            ),
            image,
            SizedBox(
              width: 16.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Color.fromRGBO(47, 48, 55, 1),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  softWrap: true,
                  text1,
                  style: TextStyle(
                    color: Color.fromRGBO(106, 108, 123, 1),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                )
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.0), // Transparent blue
            border: Border.all(width: 1, color: Color.fromRGBO(47, 48, 55, 1))),
      ),
    );
  }

  static customizeRichText({required VoidCallback onPressed}) {
    return RichText(
        text: TextSpan(
      children: [
        TextSpan(
          text: 'Didn’t receive the code? ',
          style: TextStyle(
            color: Color.fromRGBO(106, 108, 123, 1),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
          ),
        ),
        TextSpan(
          recognizer: TapGestureRecognizer()..onTap = onPressed,
          text: 'Request Again',
          style: TextStyle(
            color: Color.fromRGBO(46, 59, 98, 1),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
          ),
        ),
      ],
    ));
  }
}
