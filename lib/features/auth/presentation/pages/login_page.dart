import 'package:contacts_app_re014/common/core/navigation/routes.dart';
import 'package:contacts_app_re014/common/index.dart';
import 'package:contacts_app_re014/features/app/application/app_bloc.dart';
import 'package:contacts_app_re014/features/auth/application/auth_bloc.dart';
import 'package:contacts_app_re014/features/auth/domain/core/auth_status.dart';
import 'package:contacts_app_re014/features/auth/presentation/widgets/login_header_widget.dart';
import 'package:contacts_app_re014/features/auth/presentation/widgets/or_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
              case AuthStatus.authenticated:
                context.goNamed(Routes.userDetails.name);
                break;
              case AuthStatus.sessionActive:
                context.goNamed(Routes.userDetails.name);
                break;
              case AuthStatus.biometricNotSupport:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text("Sorry, biometric authentication is not supported on this device."),
                  ),
                );
                break;
              case AuthStatus.biometricSupported:
                showActionDialog(
                  context: context,
                  message: "Do you want to log in using the device’s biometrics?",
                  onAccept: () {
                    context.read<AuthBloc>().add(SetBiometric(email: state.user!.email, allow: true));
                    Navigator.of(context).pop();
                  },
                  onCancel: () {
                    context.read<AuthBloc>().add(SetBiometric(email: state.user!.email, allow: false));
                    Navigator.of(context).pop();
                  },
                );
                break;
              case AuthStatus.biometricAllowed:
                context.read<AuthBloc>().add(AskForBiometric(user: state.user!));
                break;
              case AuthStatus.biometricSuccess:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Your authentication was completed successfully."),
                  ),
                );
                context.goNamed(Routes.userDetails.name);
                break;

              default:
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case AuthStatus.checkingUserSession:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.lightBlueAccent,
                  ),
                );
              case AuthStatus.sessionActive:
                return Container();

              case AuthStatus.biometricFail:
                return Container(
                  margin: EdgeInsets.all(size.height * .04),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: size.height * .14,
                        color: Colors.redAccent,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * .04, bottom: size.height * .04),
                        child: const Text(
                          'There was a failure in your authentication, please try again.​',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                            onTap: () {
                              context.read<AuthBloc>().add(AskForBiometric(user: state.user!));
                            },
                            child: SvgPicture.asset(
                              AppImages.authBio,
                              semanticsLabel: 'Acme Logo',
                              height: size.height * .08,
                              colorFilter: const ColorFilter.mode(Colors.blueGrey, BlendMode.srcIn),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: size.height * .02),
                        child: const OrDivider(),
                      ),
                      GestureDetector(
                        onTap: () => context.read<AuthBloc>().add(AuthInitialEvent(loginOnlyWithCred: true)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Go to Sig In​',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18, color: Colors.lightBlue),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.lightBlue,
                              size: 28,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );

              default:
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * .08),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Form(
                            key: formKey,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LoginHeaderWidget(size: size),
                                    SizedBox(height: size.height * .04),
                                    CustomTextFormField(
                                      hintText: "User email",
                                      controller: emailController,
                                      textInputAction: TextInputAction.next,
                                      textInputType: TextInputType.emailAddress,
                                      textCapitalization: TextCapitalization.none,
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
                                      enable: formKey.currentState != null && formKey.currentState!.validate(),
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
                                    const OrDivider(),
                                    CustomButton(
                                      text: 'Sign Up',
                                      color: Colors.blueGrey,
                                      suffixIcon: const Icon(
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
    context.read<AuthBloc>().add(AuthLogin(
          email: emailController.text,
          password: passController.text,
        ));
    context.read<AppBloc>().add(AppInitialEvent());
  }
}
