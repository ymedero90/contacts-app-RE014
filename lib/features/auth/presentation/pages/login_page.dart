import 'package:contacts_app_re014/common/core/navigation/routes.dart';
import 'package:contacts_app_re014/common/index.dart';
import 'package:contacts_app_re014/features/auth/application/auth_bloc.dart';
import 'package:contacts_app_re014/features/auth/domain/core/auth_status.dart';
import 'package:contacts_app_re014/features/auth/presentation/widgets/login_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(text: 'ymedero90@gmail.com');
  TextEditingController passController = TextEditingController(text: 'qwerty123');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.unauthenticated:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text("User not found or incorrect credentials. Please check and try again."),
                  ),
                );
                break;
              default:
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case AuthStatus.checkingUserSession:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              default:
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * .08),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoginHeaderWidget(size: size),
                        Expanded(
                          child: Form(
                            key: formKey,
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextFormField(
                                      hintText: "User email",
                                      controller: emailController,
                                      textInputAction: TextInputAction.next,
                                      textInputType: TextInputType.emailAddress,
                                      onChanged: (p0) {},
                                      validator: (value) {
                                        return AppValidators.emailSimpleValidator(value);
                                      },
                                    ),
                                    SizedBox(height: size.height * .02),
                                    CustomTextFormField(
                                      hintText: "Password",
                                      controller: passController,
                                      textInputAction: TextInputAction.done,
                                      textInputType: TextInputType.visiblePassword,
                                      isPasswordType: true,
                                      onChanged: (p0) {},
                                      validator: (value) {
                                        return AppValidators.passwordSimpleValidator(value);
                                      },
                                    ),
                                    CustomButton(
                                      text: 'Sign In',
                                      suffixIcon: state.status == AuthStatus.submitting
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
                                      onPressed: () => state.status != AuthStatus.submitting ? onSubmit() : {},
                                    ),
                                    CustomButton(
                                      text: 'Sign Up',
                                      color: Colors.blueGrey,
                                      suffixIcon: state.status == AuthStatus.submitting
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
                                      margin: EdgeInsets.only(top: size.height * .01),
                                      onPressed: () => context.pushNamed(Routes.userRegister.name),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthLogin(
            email: emailController.text,
            password: passController.text,
          ));
    }
  }
}
