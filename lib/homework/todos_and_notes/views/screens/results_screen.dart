import 'package:flutter/material.dart';

import '../../viewmodels/todo_view_model.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final TodoViewModel _todoViewModel = TodoViewModel();

  int doneTodo = 0;
  int unDoneTodo = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todoViewModel.countDoneTodo().then(
          (value) {
        doneTodo = value['done'] ?? 0;
        unDoneTodo = value['undone'] ?? 0;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.green.withOpacity(0.5),
                  child: Column(
                    children: [
                      Text(
                        '$doneTodo',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 40,color: Colors.white
                            ),
                      ),
                      const Text(
                        'Done',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.white
                          //color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red.withOpacity(0.5),
                    child: Column(
                    children: [
                      Text(
                        '$unDoneTodo',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 40,
                          color: Colors.white
                            ),
                      ),
                      const Text(
                        'Not Done',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.white
                        ),
                      ),
                    ],
                                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}