import 'package:contacts_app_re014/common/core/navigation/routes.dart';
import 'package:contacts_app_re014/common/index.dart';
import 'package:contacts_app_re014/features/users/application/user_details/index.dart';
import 'package:contacts_app_re014/features/users/domain/core/user_details_status.dart';
import 'package:contacts_app_re014/features/users/presentation/widgets/user_details_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<UserDetailsBloc, UserDetailsState>(
          listener: (context, state) {
            switch (state.status) {
              case UserDetailsStatus.success:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("User registered successfully."),
                  ),
                );
                context.pop();
                break;
              case UserDetailsStatus.fail:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text("Something went wrong. Please check and try again."),
                  ),
                );
                break;
              case UserDetailsStatus.logout:
                context.goNamed(Routes.login.name);
                break;
              default:
            }
          },
          builder: (context, state) {
            if (state.status == UserDetailsStatus.loadingUser) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.lightBlueAccent,
                ),
              );
            }
            if (state.status == UserDetailsStatus.logout) {
              return Container();
            }
            return GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      if (state.user != null)
                        UserDetailsHeaderWidget(
                          user: state.user!,
                          onLogout: () {
                            context.read<UserDetailsBloc>().add(
                                  OnLogoutEvent(userEmail: state.user!.email),
                                );
                          },
                        ),
                      SizedBox(height: size.height * .04),
                      AvatarWidget(
                          avatarPath: state.user?.avatar,
                          onChangeAvatar: (source) {
                            context.read<UserDetailsBloc>().add(
                                  OnChangeUserAvatarEvent(source: source),
                                );
                          }),
                      SizedBox(height: size.height * .04),
                      Text(
                        state.user?.name ?? '',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Text(
                        state.user?.email ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(size.width * .08),
                    child: CustomButton(
                      text: 'Contacts',
                      suffixIcon: const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                      margin: EdgeInsets.only(top: size.height * .04, bottom: size.height * .01),
                      onPressed: () {
                        context.pushNamed(Routes.contactList.name);
                      },
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
}
