import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/enums.dart';
import '../../logic/cubit/counter_cubit.dart';
import '../../logic/cubit/internet_cubit.dart';
import '../../logic/cubit/life_counter_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title, this.color})
      : super(key: key);

  final Color? color;
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final lifeCounterCubit = LifeCounterCubit();
  late Timer timer;

  bool _active = true;
  String _appLifecycleState = '';

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      debugPrint('resumed');
      _active = true;
      setState(() {
        _appLifecycleState = 'resumed';
      });
    } else if (state == AppLifecycleState.paused) {
      debugPrint('paused');
      _active = false;
      setState(() {
        _appLifecycleState = 'paused';
      });
    } else if (state == AppLifecycleState.inactive) {
      debugPrint('inactive');
      _active = false;
      setState(() {
        _appLifecycleState = 'inactive';
      });
    } else if (state == AppLifecycleState.detached) {
      debugPrint('detached');
      setState(() {
        _appLifecycleState = 'detached';
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    timer = Timer.periodic(const Duration(seconds: 1), (tm) {
      if (_active) {
        lifeCounterCubit.emitLifeCounterLoaded();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('$runtimeType, build');
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.wifi) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wi-Fi Connected!'),
            duration: Duration(seconds: 3),
          ));
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.mobile) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Mobile Connected!'),
            duration: Duration(seconds: 3),
          ));
        } else if (state is InternetDisconnected) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Disconnected!'),
            duration: Duration(seconds: 3),
          ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: widget.color,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // connectionType
              BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.wifi) {
                  return Text(
                    'Wi-Fi',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Colors.green),
                  );
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.mobile) {
                  return Text(
                    'Mobile',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Colors.red),
                  );
                } else if (state is InternetDisconnected) {
                  return Text(
                    'Disconnected',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Colors.grey),
                  );
                }
                return const CircularProgressIndicator();
              }),
              const Text(
                'AppLifecycleState:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // _appLifecycleState
              Text(
                _appLifecycleState,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const Text('timelapse:'),
              //  counterCubit.stream / snapshot.data?.counterValue
              BlocProvider.value(
                value: lifeCounterCubit,
                child: BlocBuilder<LifeCounterCubit, LifeCounterState>(
                    builder: (context, state) {
                  if (state is LifeCounterLoaded) {
                    return Text(
                      '${state.counterValue}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                }),
              ),
              const Text('times:'),
              // counterValue
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncrement == true) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Incremented!'),
                      duration: Duration(milliseconds: 300),
                    ));
                  } else if (state.wasIncrement == false) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Decremented!'),
                      duration: Duration(milliseconds: 300),
                    ));
                  }
                },
                builder: (context, state) {
                  return Text(
                    '${state.counterValue}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              // Go the second screen
              Builder(
                builder: (builderContext) => MaterialButton(
                  color: widget.color,
                  onPressed: () {
                    // Navigator.of(context).pushNamed('/second');
                    Navigator.of(context).pushNamed('/second');
                  },
                  child: const Text('Go the second screen'),
                ),
              ),
              const SizedBox(height: 10),
              // Go the third screen
              Builder(
                builder: (builderContext) => MaterialButton(
                  color: widget.color,
                  onPressed: () {
                    // Navigator.of(context).pushNamed('/second');
                    Navigator.of(builderContext).pushNamed('/third');
                  },
                  child: const Text('Go the third screen'),
                ),
              ),
              const SizedBox(height: 10),
              // Go the web screen
              MaterialButton(
                color: widget.color,
                onPressed: () {
                  Navigator.of(context).pushNamed('/web');
                },
                child: const Text('Go the web screen'),
              ),
              const SizedBox(height: 10),
              // Go the settings screen
              MaterialButton(
                color: widget.color,
                onPressed: () {
                  Navigator.of(context).pushNamed('/settings');
                },
                child: const Text('Go the settings screen'),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'fab1',
                backgroundColor: widget.color,
                onPressed: () {
                  context.read<CounterCubit>().increment();
                  //BlocProvider.of<CounterCubit>(context).increment();
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 5),
              FloatingActionButton(
                heroTag: 'fab2',
                backgroundColor: widget.color,
                onPressed: () {
                  context.read<CounterCubit>().decrement();
                  //BlocProvider.of<CounterCubit>(context).decrement();
                },
                tooltip: 'Decrement',
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
