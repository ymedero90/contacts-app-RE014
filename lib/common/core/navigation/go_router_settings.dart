import 'package:contacts_app_re014/common/core/navigation/routes.dart';
import 'package:contacts_app_re014/common/domain/dependencies_container/injector.dart';
import 'package:contacts_app_re014/features/auth/application/auth_bloc.dart';
import 'package:contacts_app_re014/features/auth/presentation/index.dart';
import 'package:contacts_app_re014/features/contacts/application/contact_register/contact_register_bloc.dart';
import 'package:contacts_app_re014/features/contacts/application/contacts_list/contacts_list_bloc.dart';
import 'package:contacts_app_re014/features/contacts/presentation/pages/contact_list_page.dart';
import 'package:contacts_app_re014/features/contacts/presentation/pages/contact_register_page.dart';
import 'package:contacts_app_re014/features/users/application/user_details/user_details_bloc.dart';
import 'package:contacts_app_re014/features/users/application/user_register/register_bloc.dart';
import 'package:contacts_app_re014/features/users/presentation/pages/user_details_page.dart';
import 'package:contacts_app_re014/features/users/presentation/pages/user_register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GoRouterSettings {
  static String currentRoute = Routes.login.name;
  static BuildContext? currentContext;
  static final GoRouter router = GoRouter(
    initialLocation: Routes.login.path,
    routes: [
      GoRoute(
        name: Routes.login.name,
        path: Routes.login.path,
        builder: (context, state) {
          currentRoute = Routes.login.name;
          currentContext = context;
          return BlocProvider(
            create: (context) => Injector.sl<AuthBloc>(),
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        name: Routes.userRegister.name,
        path: Routes.userRegister.path,
        builder: (context, state) {
          currentRoute = Routes.userRegister.name;
          currentContext = context;
          return BlocProvider(
            create: (context) => Injector.sl<RegisterUserFormBloc>(),
            child: const UserRegisterPage(),
          );
        },
      ),
      GoRoute(
        name: Routes.userDetails.name,
        path: Routes.userDetails.path,
        builder: (context, state) {
          currentContext = context;
          currentRoute = Routes.userDetails.name;
          return BlocProvider(
            create: (context) => Injector.sl<UserDetailsBloc>(),
            child: const UserDetailsPage(),
          );
        },
      ),
      GoRoute(
        name: Routes.contactList.name,
        path: Routes.contactList.path,
        builder: (context, state) {
          currentContext = context;
          currentRoute = Routes.contactList.name;
          return BlocProvider(
            create: (context) => Injector.sl<ContactListBloc>(),
            child: const ContactListPage(),
          );
        },
      ),
      GoRoute(
        name: Routes.contactRegister.name,
        path: Routes.contactRegister.path,
        builder: (context, state) {
          currentContext = context;
          currentRoute = Routes.contactRegister.name;
          return BlocProvider(
            create: (context) => Injector.sl<RegisterContactFormBloc>(),
            child: const ContactRegisterPage(),
          );
        },
      ),
    ],
  );
}
