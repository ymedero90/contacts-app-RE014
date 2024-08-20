import 'dart:io';

import 'package:contacts_app_re014/features/users/application/user_details/user_details_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({
    super.key,
    this.avatarPath,
    required this.onChangeAvatar,
  });

  final String? avatarPath;
  final Function(ImageSource source) onChangeAvatar;

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.white,
            height: size.height * .14,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.onChangeAvatar(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.camera_alt_rounded,
                    size: size.width * .16,
                    color: Colors.lightBlue,
                  ),
                ),
                SizedBox(width: size.width * .2),
                GestureDetector(
                  onTap: () {
                    widget.onChangeAvatar(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.photo,
                    size: size.width * .16,
                    color: Colors.lightBlue,
                  ),
                )
              ],
            ),
          );
        },
      ),
      child: Stack(
        children: [
          CircleAvatar(
            radius: size.height * .1,
            backgroundColor: Colors.lightBlue,
            backgroundImage: widget.avatarPath != null ? FileImage(File(widget.avatarPath!)) : null,
            child: widget.avatarPath == null
                ? Icon(
                    Icons.person,
                    color: Colors.white,
                    size: size.height * .12,
                  )
                : Container(),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(size.height * .01),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(size.height * .04)),
              child: Icon(
                Icons.edit,
                color: Colors.lightBlue,
                size: size.height * .04,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
