import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Addquestionscreen extends StatefulWidget {
  const Addquestionscreen({super.key});

  @override
  State<Addquestionscreen> createState() => _AddquestionscreenState();
}

class _AddquestionscreenState extends State<Addquestionscreen> {
  TextEditingController quizName = TextEditingController();
  TextEditingController referenceUrl = TextEditingController();

  List<Map<String, dynamic>> questions = [];
  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  TextEditingController option4Controller = TextEditingController();
  TextEditingController answerController = TextEditingController();

  String? quizId;

  void addQuestion() {
    if (questionController.text.isNotEmpty &&
        option1Controller.text.isNotEmpty &&
        option2Controller.text.isNotEmpty &&
        option3Controller.text.isNotEmpty &&
        option4Controller.text.isNotEmpty &&
        answerController.text.isNotEmpty) {
      questions.add({
        'question': questionController.text,
        'option': [
          option1Controller.text.toString(),
          option2Controller.text.toString(),
          option3Controller.text.toString(),
          option4Controller.text.toString()
        ],
        'answer': answerController.text.toString(),
      });

      // Clear fields
      questionController.clear();
      option1Controller.clear();
      option2Controller.clear();
      option3Controller.clear();
      option4Controller.clear();
      answerController.clear();

      setState(() {});
    }
  }

  Future<void> saveQuiz() async {
    if (quizId != null && questions.isNotEmpty) {
      final docRef = FirebaseFirestore.instance
          .collection('Questions')
          .doc(quizId)
          .collection('ListQuestion');

      for (var question in questions) {
        await docRef.add(question);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quiz saved successfully!')),
      );

      setState(() {
        questions.clear();
        quizName.clear();
        referenceUrl.clear();
        quizId = null;
      });
    }
  }

  Future<void> createQuiz() async {
    if (quizName.text.isNotEmpty && referenceUrl.text.isNotEmpty) {
      final docRef = await FirebaseFirestore.instance
          .collection('Questions')
          .add({
        'name': quizName.text,
        'image': referenceUrl.text,
      });

      setState(() {
        quizId = docRef.id;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quiz created successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quiz name and image URL are required!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Quiz')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (quizId == null) ...[
                TextField(
                  controller: quizName,
                  decoration: const InputDecoration(labelText: 'Quiz Name'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: referenceUrl,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: createQuiz,
                  child: const Text('Create Quiz'),
                ),
              ] else ...[
                TextField(
                  controller: questionController,
                  decoration: const InputDecoration(labelText: 'Question'),
                ),
                TextField(
                  controller: option1Controller,
                  decoration: const InputDecoration(labelText: 'Option 1'),
                ),
                TextField(
                  controller: option2Controller,
                  decoration: const InputDecoration(labelText: 'Option 2'),
                ),
                TextField(
                  controller: option3Controller,
                  decoration: const InputDecoration(labelText: 'Option 3'),
                ),
                TextField(
                  controller: option4Controller,
                  decoration: const InputDecoration(labelText: 'Option 4'),
                ),
                TextField(
                  controller: answerController,
                  decoration: const InputDecoration(labelText: 'Correct Answer'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: addQuestion,
                  child: const Text('Add Question'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: saveQuiz,
                  child: const Text('Save Quiz'),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(questions[index]['question']),
                      subtitle: Text(questions[index]['option'].join(', ')),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}