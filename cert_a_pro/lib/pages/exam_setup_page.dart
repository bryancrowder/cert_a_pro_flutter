import 'package:cert_a_pro/providers/exam.dart';
import 'package:cert_a_pro/providers/question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/answer.dart';
import '../providers/certification_provider.dart';

class ExamSetupPage extends StatefulWidget {
  const ExamSetupPage({super.key});

  static const routeName = '/exam-setup-page';

  @override
  State<ExamSetupPage> createState() => _ExamSetupPageState();
}

// @override
// void initState() {
//   super.initState();
// }

class _ExamSetupPageState extends State<ExamSetupPage> {
  final _titleController = TextEditingController();
  int? _dropDown = 0;
  final _formKey = GlobalKey<FormState>();
  // var newExam = Exam(
  //     id: "",
  //     certID: "",
  //     title: "",
  //     questions: [],
  //     state: States.ready,
  //     answers: []);

  var initValues = {
    "title": "",
    "questions": 0,
  };
  @override
  void initState() {
    super.initState();
  }

  // ignore: prefer_final_fields, unused_field
  var _isInit = true;
  // ignore: prefer_final_fields, unused_field
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    //   if (_isInit) {
    //     if (ModalRoute.of(context)!.settings.arguments != null) {
    //       final certID = ModalRoute.of(context)!.settings.arguments as String;
    //       newExam = Provider.of<Exams>(context, listen: false).addExam(certID, 0);

    //       initValues = {
    //         "title": newExam.title,
    //         "questions": newExam.questions,
    //       };
    //     }
    //   }
    //   _isInit = false;

    super.didChangeDependencies();
  }

  Future<void> _saveForm(List<Answer> questions) async {
    final certID = ModalRoute.of(context)?.settings.arguments as String;
    Provider.of<Exams>(context, listen: false)
        .createExam(_titleController.text, certID, _dropDown!, questions.cast<Question>());
  }

  @override
  Widget build(BuildContext context) {
    final certID = ModalRoute.of(context)?.settings.arguments as String;
    final questions = Provider.of<Questions>(context, listen: false)
        .getQuestionsExams(certID);
    final certs = Provider.of<Certifications>(context).findCertByID(certID);
    return Scaffold(
      appBar: AppBar(
        title: Text(certs.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(labelText: "Exam Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Exam Title';
                  }
                  return null;
                },
                controller: _titleController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: DropdownButtonFormField(
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Theme.of(context).colorScheme.primary,
                  decoration:
                      const InputDecoration(labelText: "How Many Questions?"),
                  items: const [
                    DropdownMenuItem(
                      value: 10,
                      child: Text("10"),
                    ),
                    DropdownMenuItem(value: 15, child: Text("15")),
                    DropdownMenuItem(value: 30, child: Text("30")),
                    DropdownMenuItem(value: 45, child: Text("45")),
                    DropdownMenuItem(value: 60, child: Text("60")),
                  ],
                  onChanged: (value) {
                    _dropDown = value;
                  },
                  validator: (value) => value == null ? 'Field Required' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Building Practice Exam')),
                      );
                      _saveForm(questions.cast<Answer>());
                    }
                  },
                  child: const Text('Start Practice Exam'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
