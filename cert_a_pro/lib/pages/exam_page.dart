import 'package:cert_a_pro/widgets/exam_question.dart';
import 'package:flutter/material.dart';


class ExamPage extends StatelessWidget {
  const ExamPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Practice Exam")),
      body: const Padding(
        padding: EdgeInsets.all(15),
        child: ExamQuestion(),
      ),
    );
  }
}
