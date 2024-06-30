import 'package:flutter/material.dart';

class UiHelper {
  static customizeText(String text) {
    return Text(
      text,
      style: const TextStyle(
          letterSpacing: 0.07,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Color.fromRGBO(0, 0, 0, 1)),
    );
  }

  static customizeTextSmall(String text) {
    return Text(text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          letterSpacing: 0.07,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color.fromRGBO(106, 108, 123, 1),
        ));
  }

  static customizeTextCountry(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color.fromARGB(45, 17, 19, 1),
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    );
  }

  static customizeTextButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Color.fromRGBO(47, 48, 55, 1),
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          fontSize: 16,
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
            fontSize: 16,
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
      required String text,
      required String text1,
      required VoidCallback onPressed,
      required bool isFilled}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 328,
        height: 89,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Icon(
                  isFilled ? Icons.circle : Icons.circle_outlined,
                  size: isFilled ? 16 : 24,
                  color: isFilled ? Color.fromRGBO(46, 59, 98, 1) : null,
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10), child: image
                  // Image.asset('assets/images/truck.png'),
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
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    softWrap: true,
                    text1,
                    style: TextStyle(
                      color: Color.fromRGBO(106, 108, 123, 1),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.0), // Transparent blue
            border: Border.all(width: 1, color: Color.fromRGBO(47, 48, 55, 1))),
      ),
    );
  }

  static customizeRichText() {
    return RichText(
        text: const TextSpan(
      children: [
        TextSpan(
          text: 'Didn’t receive the code? ',
          style: TextStyle(
            color: Color.fromRGBO(106, 108, 123, 1),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        TextSpan(
          text: 'Request Again',
          style: TextStyle(
            color: Color.fromRGBO(46, 59, 98, 1),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ],
    ));
  }
}
