import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Quizscreen extends StatefulWidget {
  const Quizscreen({super.key, required this.question});
  final DocumentSnapshot question;

  @override
  State<Quizscreen> createState() => _QuizscreenState();
}

class _QuizscreenState extends State<Quizscreen> {
  late Future<List<QueryDocumentSnapshot>> questionList;
  List<Color> colors = List.generate(
      5, (index) => Colors.primaries[index % Colors.primaries.length]);

  Future<List<QueryDocumentSnapshot>> fetchSubCollection() async {
    final snapshot =
    await widget.question.reference.collection('ListQuestion').get();
    return snapshot.docs;
  }

  Future<void> deleteDocument() async {
    try {
      await widget.question.reference.delete();
      // Navigate back after successful deletion or show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quiz deleted successfully')),
      );
      Navigator.pop(context); // Navigate back to the previous screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting quiz: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    questionList = fetchSubCollection();
  }

  void onLastCardDragged() {
    setState(() {
      final color = colors.removeLast();
      colors.insert(0, color);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: const Text('Quiz'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Confirm deletion with a dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Quiz'),
                  content: const Text('Are you sure you want to delete this quiz?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                        deleteDocument(); // Call the delete function
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<QueryDocumentSnapshot>>(
          future: questionList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No questions available.');
            }
            final questions = snapshot.data!;
            List<CardModel> cards = List.generate(
              questions.length,
                  (index) {
                final question = questions[index];
                bool isCorrect = false;
                bool isTap = false;
                return CardModel(
                  radius: const Radius.circular(15),
                  child: Container(
                    height: size.height * 0.7,
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: colors[index % colors.length],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Q${index + 1}). ${question['question']}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            itemBuilder: (context, optionIndex) {
                              final options = questions.isNotEmpty &&
                                  questions[index]['option'] != null
                                  ? List<String>.from(
                                  questions[index]['option'])
                                  : [
                                'Option 1',
                                'Option 2',
                                'Option 3',
                                'Option 4'
                              ];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: isTap
                                        ? (isCorrect
                                        ? Colors.green
                                        : Colors.red)
                                        : Colors.blueGrey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (options[optionIndex] ==
                                        question[index]['answer']) {
                                      setState(() {
                                        isCorrect = true;
                                        isTap = true;
                                      });
                                    }
                                  },
                                  child: Text(
                                    options[optionIndex].toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
            return Column(
              children: [
                SizedBox(
                    height: size.height * 0.8,
                    width: size.width * 0.95,
                    child: CardStackWidget(
                      reverseOrder: true,
                      animateCardScale: true,
                      cardDismissOrientation: CardOrientation.both,
                      opacityChangeOnDrag: true,
                      scaleFactor: 0.5,
                      swipeOrientation: CardOrientation.both,
                      dismissedCardDuration: const Duration(milliseconds: 100),
                      cardList: cards,
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}