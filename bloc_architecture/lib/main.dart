import 'package:bloc_architecture/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.zero,
              mouseCursor: MouseCursor.defer,
              color: Colors.red,
              icon: const Icon(Icons.remove),
              onPressed: () {
                BlocProvider.of<CounterCubit>(context).decrement();
              },
            ),
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                return Text(
                  '${state.counter}',
                );
              },
            ),
            IconButton(
              padding: EdgeInsets.zero,
              color: Colors.green,
              icon: const Icon(Icons.add),
              onPressed: () {
                BlocProvider.of<CounterCubit>(context).increment();
              },
            ),
          ],
        ),
      ),
    );
  }
}
