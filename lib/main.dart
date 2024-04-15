import 'package:flutter/material.dart';
import 'package:firstscreen/app_bloc/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //final MyApp appBloc = BlocProvider.of<AppBloc>(context);
  final AppBloc appBloc = AppBloc();

  @override
  void initState() {
    super.initState();
    appBloc.add(IncrementEvent(0));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(leading: Icon(Icons.close), actions: [
            const Padding(
              padding: EdgeInsets.only(right: 25),
              child: Text(
                "Buy gift cards",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ]),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: 350,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.play_arrow_outlined),
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      "Google play gift card",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("\$10-\$200",
                        style: TextStyle(color: Colors.blueAccent)),
                  ],
                ),
                alignment: Alignment.bottomLeft,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const RotatedBox(
                        quarterTurns: -1,
                        child: Text("Select option",
                            style: TextStyle(color: Colors.grey))),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text("Select size",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<AppBloc, AppState>(
                              bloc: appBloc,
                              builder: (context, state) {
                                if (state is UpdatedState) {
                                  return Row(children: [
                                    ElevatedButton(
                                      onPressed: () => appBloc
                                          .add(DecrementEvent(state.count - 1)),
                                      child: const Text("-",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "${state.count}",
                                      style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    ElevatedButton(
                                      onPressed: () => appBloc
                                          .add(IncrementEvent(state.count + 1)),
                                      child: const Text(
                                        "+",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ]);
                                }
                                return SizedBox();
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("Select store",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Image.asset("assets/america.jpg",
                                    height: 30, width: 30),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Image.asset("assets/india.webp",
                                    height: 30, width: 30),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Image.asset("assets/south_Africa.png",
                                    height: 30, width: 30),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      children: [
                        Text(
                          "Select size",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        Text(
                          "\$104.50",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 90,
                    ),
                    Container(
                      height: 75,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.lightBlue,
                      ),
                      child: const Text(
                        "Add to cart",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
