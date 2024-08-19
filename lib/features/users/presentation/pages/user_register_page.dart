import 'package:contacts_app_re014/common/index.dart';
import 'package:contacts_app_re014/features/users/application/user_register/register_bloc.dart';
import 'package:contacts_app_re014/features/users/domain/core/user_register_status.dart';
import 'package:contacts_app_re014/features/users/presentation/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(text: 'Yoel');
  TextEditingController emailController = TextEditingController(text: 'ymedero90@gmail.com');
  TextEditingController passController = TextEditingController(text: 'Qwerty12345@');
  TextEditingController confirmPassController = TextEditingController(text: 'Qwerty12345@');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RegisterUserFormBloc, RegisterUserFormState>(
          listener: (context, state) {
            switch (state.status) {
              case RegisterUserStatus.success:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("User registered successfully."),
                  ),
                );
                context.pop();
                break;
              case RegisterUserStatus.fail:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text("Something went wrong. Please check and try again."),
                  ),
                );
                break;
              case RegisterUserStatus.emailAlreadyExist:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text("A user with this email is already registered."),
                  ),
                );
                break;

              default:
            }
          },
          builder: (context, state) {
            return GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserRegisterHeaderWidget(size: size),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: size.width * .08, vertical: size.height * .06),
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CustomTextFormField(
                                hintText: "User Name",
                                controller: nameController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.name,
                                onChanged: (p0) {},
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
                                validator: (value) {
                                  return AppValidators.nameValidator(value);
                                },
                              ),
                              SizedBox(height: size.height * .02),
                              CustomTextFormField(
                                hintText: "User Email",
                                controller: emailController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.emailAddress,
                                onChanged: (p0) {},
                                validator: (value) {
                                  return AppValidators.emailValidator(value);
                                },
                              ),
                              SizedBox(height: size.height * .02),
                              CustomTextFormField(
                                hintText: "Password",
                                controller: passController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.visiblePassword,
                                isPasswordType: true,
                                onChanged: (p0) {},
                                validator: (value) {
                                  return AppValidators.passwordValidator(value);
                                },
                              ),
                              SizedBox(height: size.height * .02),
                              CustomTextFormField(
                                hintText: "Confirm Password",
                                controller: confirmPassController,
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.visiblePassword,
                                isPasswordType: true,
                                onChanged: (p0) {},
                                validator: (value) {
                                  return AppValidators.passwordMatchValidator(passController.text, value);
                                },
                              ),
                              CustomButton(
                                text: 'Save',
                                suffixIcon: state.status == RegisterUserStatus.submitting
                                    ? SizedBox(
                                        height: size.height * .033,
                                        width: size.height * .033,
                                        child: const CircularProgressIndicator(color: Colors.white),
                                      )
                                    : const Icon(
                                        Icons.chevron_right_rounded,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                margin: EdgeInsets.only(top: size.height * .04, bottom: size.height * .01),
                                onPressed: () => state.status != RegisterUserStatus.submitting ? onSubmit() : {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      context.read<RegisterUserFormBloc>().add(
            FormSubmitted(
              name: nameController.text,
              email: emailController.text,
              password: passController.text,
            ),
          );
    }
  }
}
