import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BackEyes/screens/members/cubit/cubit.dart';
import 'package:BackEyes/screens/splash/splash.dart';
import 'package:BackEyes/shared/network/local_network.dart';
import 'package:BackEyes/shared/observer.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheNetwork.cacheInitalization();
  CacheNetwork.getCacheData(key: 'token');
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MembersCubit()..getMembers(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                color: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(
                    color: Color(0xff000000)
                )

            )
        ),
        home: SplashScreen(),
      ),
    );
  }
}

