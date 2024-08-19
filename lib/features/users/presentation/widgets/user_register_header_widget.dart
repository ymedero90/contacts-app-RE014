import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserRegisterHeaderWidget extends StatelessWidget {
  const UserRegisterHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            child: Icon(
              Icons.chevron_left,
              size: size.height * .08,
              color: Colors.lightBlue,
            ),
            onTap: () => context.pop(),
          ),
        ),
        const Text(
          "Register",
          style: TextStyle(
            fontSize: 46,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        const Text(
          "User",
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}
