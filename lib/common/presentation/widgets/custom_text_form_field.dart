import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.validator,
    this.isPasswordType = false,
    this.textInputType,
    this.textInputAction,
    this.textCapitalization,
    this.controller,
    this.inputFormatters,
    this.autovalidateMode,
  });
  final String hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool isPasswordType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;

  @override
  State<CustomTextFormField> createState() => _CustomtextFormFieldState();
}

class _CustomtextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = false;
  @override
  void initState() {
    obscureText = widget.isPasswordType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextFormField(
      autovalidateMode: widget.autovalidateMode,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      controller: widget.controller,
      style: Theme.of(context).textTheme.bodyLarge,
      onChanged: widget.onChanged,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.words,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.blueGrey),
        errorMaxLines: 2,
        border: InputBorder.none,
        fillColor: Colors.white,
        filled: true,
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
        suffixIcon: widget.isPasswordType
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.blueGrey,
                ),
              )
            : null,
      ),
    );
  }
}
