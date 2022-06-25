import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter20220623/logic/cubit/counter_cubit.dart';
import 'package:flutter20220623/logic/cubit/life_counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key, required this.title, this.color})
      : super(key: key);

  final Color? color;
  final String title;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with WidgetsBindingObserver {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'AppLifecycleState:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _appLifecycleState,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.color,
              ),
            ),
            const Text('timelapse:'),
            // counterCubit.stream
            StreamBuilder<LifeCounterState>(
              stream: lifeCounterCubit.stream,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Text(
                    '${snapshot.data?.counterValue}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            const Text('times:'),
            // CounterCubit, state.counterValue
            BlocBuilder<CounterCubit, CounterState>(
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
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/third');
              },
              color: widget.color,
              child: const Text('Go the third screen'),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'fab1',
            backgroundColor: widget.color,
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 5),
          FloatingActionButton(
            heroTag: 'fab2',
            backgroundColor: widget.color,
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).decrement();
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
