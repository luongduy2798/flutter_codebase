import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:turtle/app/utils/extensions/extension_context.dart';
import 'app/provider/authentication_bloc/authentication_bloc.dart';
import 'app/screens/login_screen.dart';
import 'app/screens/main_screen.dart';
import 'app/utils/app_theme.dart';
import 'app/utils/easy_loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listenWhen: (previous, current) =>
                previous.logoutStatus != current.logoutStatus,
            listener: (context, state) {
              if (state.logoutStatus == LogoutStatus.loading) {
                showLoading();
                return;
              }

              if (state.logoutStatus == LogoutStatus.finish) {
                dismissLoading();
                return;
              }
            },
          ),
        ],
        child: GestureDetector(
          // Dismiss keyboard when clicked outside
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppThemes().themData(context),
            home: const Main(),
            builder: EasyLoading.init(builder: (context, child) {
              return child ?? const SizedBox.shrink();
            }),
          ),
        ),
      ),
    );
  }
}

class Main extends StatefulWidget {
  const Main({
    Key? key,
  }) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) async {
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              context.navigateOpacity(const MainScreen(),
                  pushAndRemoveUntil: true);
              break;
            case AuthenticationStatus.unauthenticated:
              context.navigateOpacity(const LoginScreen(),
                  pushAndRemoveUntil: true);
              break;
            default:
              break;
          }
        },
        child: Container());
  }
}
