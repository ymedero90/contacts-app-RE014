import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactRegisterHeaderWidget extends StatelessWidget {
  const ContactRegisterHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            child: Icon(
              Icons.chevron_left,
              size: size.height * .06,
              color: Colors.lightBlue,
            ),
            onTap: () => context.pop(),
          ),
        ),
        const Text(
          "Register Contact",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}
