import 'package:flutter/material.dart';
import 'package:quizapp/quiz_list.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  List<String?> selectedOptions;
  DetailScreen({required this.selectedOptions, super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<String?> answers = quizQuestions.map((e) => e.answer).toList();
  int score = 0;

  @override
  void initState() {
    super.initState();
    // ignore: avoid_function_literals_in_foreach_calls
    // use widget.whatever to access attricbutes in a stateful widget
    widget.selectedOptions.forEach((option) {
      if (answers.contains(option)) {
        score++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        title: const Text("Detail Screen"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Your total Score is : ${score.toString()} / ${widget.selectedOptions.length}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          ...widget.selectedOptions.map((selected) {
            int index = widget.selectedOptions.indexOf(selected);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${index + 1}.",
                    style: const TextStyle(color: Colors.black),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("You selected : "),
                          Text(widget.selectedOptions[index]!),
                          answers.contains(widget.selectedOptions[index])
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green[700],
                                )
                              : const Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Correct answer is : "),
                          Text(answers[index]!),
                          Icon(
                            Icons.check,
                            color: Colors.green[700],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
