import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        const Expanded(
          child: Divider(
            thickness: .5,
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .04, vertical: size.height * .015),
          child: const Text(
            "or",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            thickness: .5,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
