import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizapp/quiz_list.dart';
import 'package:quizapp/screens/detail_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String?> selectedOptions = List.filled(10, null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        title: const Text(
          "Quiz App",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                text: "Welcome!, Anon Player!\n",
                children: [
                  TextSpan(
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                    text: "Please, answer the following questions: ",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ...quizQuestions.map((quiz) {
                    int questionIndex = quizQuestions.indexOf(quiz);
                    return Card(
                      elevation: 5,
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                quiz.question!,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              ...quiz.options!.map(
                                (option) {
                                  return RadioListTile(
                                    title: Text(option),
                                    value: option,
                                    groupValue: selectedOptions[questionIndex],
                                    onChanged: (val) {
                                      setState(() {
                                        selectedOptions[questionIndex] = val!;
                                      });
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 3,
                    ),
                    onPressed: () {
                      selectedOptions.contains(null)
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Go back and finish your work lazy person"),
                              ),
                            )
                          : {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    selectedOptions: selectedOptions,
                                  ),
                                ),
                              ).then((_) => setState(() {
                                    selectedOptions = List.filled(10, null);
                                  })),
                            };
                    },
                    icon: const Icon(
                      Icons.check,
                      size: 25,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
