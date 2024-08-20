import 'package:contacts_app_re014/features/users/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class UserDetailsHeaderWidget extends StatelessWidget {
  const UserDetailsHeaderWidget({
    super.key,
    required this.user,
    required this.onLogout,
  });

  final UserEntity user;
  final Function() onLogout;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(top: size.width * .04, right: size.width * .04),
            child: Icon(
              Icons.logout_outlined,
              size: size.height * .048,
              color: Colors.lightBlue,
            ),
          ),
          onTap: () => onLogout(),
        ),
      ],
    );
  }
}
