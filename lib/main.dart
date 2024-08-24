import 'package:contacts_app_re014/common/core/navigation/go_router_settings.dart';
import 'package:contacts_app_re014/common/core/navigation/routes.dart';
import 'package:contacts_app_re014/common/domain/dependencies_container/injector.dart';
import 'package:contacts_app_re014/common/presentation/widgets/dialogs/custom_dialogs.dart';
import 'package:contacts_app_re014/features/app/application/app_bloc.dart';
import 'package:contacts_app_re014/features/app/domain/core/app_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  await dotenv.load(fileName: ".env");
  await Injector.onInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouterSettings.router,
      title: 'Contacs App',
      builder: (contextRouter, child) {
        return BlocProvider(
          create: (contextProv) => Injector.sl<AppBloc>(),
          child: BlocListener<AppBloc, AppState>(
            listenWhen: (contextListen, state) {
              return GoRouterSettings.currentRoute != Routes.login.name &&
                  GoRouterSettings.currentRoute != Routes.userRegister.name;
            },
            listener: (BuildContext context, AppState state) {
              switch (state.status) {
                case AppStatus.sessionExpired:
                  showActionDialog(
                    context: GoRouterSettings.currentContext!,
                    message:
                        "The session has expired. You have 10 seconds to renew it; otherwise, the session will close. Would you like to renew it?​",
                    onAccept: () {
                      context.read<AppBloc>().add(AppSessionRenew(renew: true));
                      Navigator.of(GoRouterSettings.currentContext!).pop();
                    },
                    onCancel: () {
                      context.read<AppBloc>().add(AppSessionRenew(renew: false));
                      Navigator.of(GoRouterSettings.currentContext!).pop();
                    },
                  );
                  break;

                case AppStatus.sessionFinished:
                  GoRouterSettings.currentContext!.goNamed(Routes.login.name);

                  break;
                default:
              }
            },
            child: child!,
          ),
        );
      },
    );
  }
}
