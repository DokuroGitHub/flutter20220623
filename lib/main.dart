import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'logic/cubit/counter_cubit.dart';
import 'logic/cubit/internet_cubit.dart';
import 'logic/cubit/settings_cubit.dart';
import 'logic/utility/app_bloc_observer.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  final blocObserver = AppBlocObserver();

  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(
      appRouter: AppRouter(),
      connectivity: Connectivity(),
    )),
    storage: storage,
    blocObserver: blocObserver,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.appRouter,
    required this.connectivity,
  }) : super(key: key);

  final AppRouter appRouter;
  final Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (BuildContext context) => InternetCubit(
            connectivity: connectivity,
          ),
        ),
        BlocProvider<CounterCubit>(
          create: (BuildContext context) => CounterCubit(),
        ),
        BlocProvider<SettingsCubit>(
          create: (BuildContext context) => SettingsCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Monstserrat'),
        onGenerateRoute: appRouter.onGenrateRoute,
      ),
    );
  }
}
