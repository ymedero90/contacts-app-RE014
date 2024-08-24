import 'package:contacts_app_re014/common/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

Future<void> showInfoDialog(BuildContext context, String message) async {
  final size = MediaQuery.of(context).size;
  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container(
        margin: EdgeInsets.all(size.height * .04),
        child: Column(
          children: [
            const Text("Info"),
            Text(message),
          ],
        ),
      );
    },
  );
}

Future<void> showActionDialog({
  required BuildContext context,
  required String message,
  required void Function() onAccept,
  required void Function() onCancel,
}) async {
  final size = MediaQuery.of(context).size;
  await showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.04),
                offset: Offset(0, 3),
                blurRadius: 5,
              )
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: size.height * .02, horizontal: size.width * .02),
          margin: EdgeInsets.symmetric(vertical: size.height * .3, horizontal: size.width * .1),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.blueGrey,
                        size: size.height * .1,
                      ),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: 'Cancel',
                color: Colors.blueGrey,
                margin: EdgeInsets.only(top: size.height * .04),
                onPressed: onCancel,
              ),
              CustomButton(
                text: 'Accept',
                margin: EdgeInsets.only(top: size.height * .01),
                onPressed: onAccept,
              ),
            ],
          ),
        ),
      );
    },
  );
}
