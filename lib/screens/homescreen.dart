import 'package:flashcard/screens/quizscreen.dart';
import 'package:flashcard/widgets/heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state_management/list_questions.dart';

class Homescreen extends ConsumerWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listQuestions = ref.watch(listQuestion);
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const Heading(
              text: 'For you', fontSize: 22, fontWeight: FontWeight.bold),
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: listQuestions.when(
                data: (questions) {
                  if (questions.isEmpty) {
                    return const Text('No questions available.');
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      final question = questions[index];
                      Route createRoute() {
                        return PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Quizscreen(
                            question: question,
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1, 0);
                            const end = Offset.zero;
                            final tween = Tween(begin: begin, end: end);
                            const curve = Curves.ease;
                            final curvedAnimation = CurvedAnimation(
                              parent: animation,
                              curve: curve,
                            );
                            return SlideTransition(
                              position: tween.animate(curvedAnimation),
                              child: child,
                            );
                          },
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, createRoute());
                          },
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 5,
                            child: Stack(
                              children: [
                                Image.network(
                                  question['image'] ??
                                      'https://media.istockphoto.com/id/1616906708/vector/vector-speech-bubble-with-quiz-time-words-trendy-text-balloon-with-geometric-grapic-shape.jpg?s=612x612&w=0&k=20&c=3-qsji8Y5QSuShaMi6cqONlVZ3womknA5CiJ4PCeZEI=',
                                  height: 190,
                                  width: 190,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                    bottom: 15,
                                    child: Heading(
                                        text: question['name'] ?? 'NO NAME',
                                        fontSize: 18.5,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (error, stack) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
