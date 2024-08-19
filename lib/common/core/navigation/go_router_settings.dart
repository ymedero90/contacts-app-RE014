import 'package:contacts_app_re014/common/core/navigation/routes.dart';
import 'package:contacts_app_re014/common/domain/dependencies_container/injector.dart';
import 'package:contacts_app_re014/features/auth/application/auth_bloc.dart';
import 'package:contacts_app_re014/features/auth/presentation/index.dart';
import 'package:contacts_app_re014/features/users/application/user_register/register_bloc.dart';
import 'package:contacts_app_re014/features/users/presentation/pages/user_register_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GoRouterSettings {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.login.path,
    routes: [
      GoRoute(
        name: Routes.login.name,
        path: Routes.login.path,
        builder: (context, state) {
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
          return BlocProvider(
            create: (context) => Injector.sl<RegisterUserFormBloc>(),
            child: const UserRegisterPage(),
          );
        },
      ),
    ],
  );
}
