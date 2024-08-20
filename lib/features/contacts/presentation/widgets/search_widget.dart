import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    this.margin,
    this.onChanged,
  });

  final EdgeInsets? margin;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: margin,
      child: TextField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(color: Colors.blueGrey),
          errorMaxLines: 2,
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: size.width * .04,
            vertical: size.height * .02,
          ),
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
