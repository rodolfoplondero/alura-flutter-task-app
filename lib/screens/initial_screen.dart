import 'package:flutter/material.dart';

import '../components/task.dart';
import '../data/task_inherited.dart';
import 'form_screen.dart';

class InitialScreen extends StatefulWidget {
  InitialScreen({Key? key}) : super(key: key);

  double personalLevel = 0;

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;

  void calculatePersonalLevel() {
    double totalLevels = 0;
    for (Task t in TaskInherited.of(context).taskList) {
      totalLevels += t.totalLevel / t.maxLevel;
    }
    widget.personalLevel = totalLevels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Tarefas'),
            SizedBox(
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 170,
                    child: LinearProgressIndicator(
                      color: Colors.white,
                      value: widget.personalLevel / 100,
                    ),
                  ),
                  Text(
                    "Nível: ${widget.personalLevel.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        calculatePersonalLevel();
                      });
                    },
                    padding: const EdgeInsets.only(bottom: 20),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        children: TaskInherited.of(context).taskList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(taskContext: context),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
