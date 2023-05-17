// ignore_for_file: unused_local_variable

import 'package:cert_a_pro/providers/answer.dart';
import 'package:cert_a_pro/providers/question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_text_field.dart';

class QuestionEdit extends StatefulWidget {
  const QuestionEdit({super.key});
  static const routeName = '/question_edit';

  @override
  State<QuestionEdit> createState() => _QuestionEditState();
}

class _QuestionEditState extends State<QuestionEdit> {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();
  bool correct = false;
  QuestionType questionType = QuestionType.selectOne;
  final _formKey = GlobalKey<FormState>();
  final List<Answer> _answers = [];
  //List<Answer> correctAnswers = [];
  Future<void> _saveForm(cert) async {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
    try {
      Provider.of<Questions>(context, listen: false)
          .addQuestion(_questionController.text, cert, _answers, questionType);
      //save data here for data base
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("An Error has Occured"),
                content: const Text("Something went wrong"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text("Okay"))
                ],
              ));
    } finally {
      Navigator.of(context).pop();
    }
  }

  _setState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final certID = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Question"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(labelText: "Question"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
                controller: _questionController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: DropdownButtonFormField(
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Theme.of(context).colorScheme.primary,
                  decoration: const InputDecoration(labelText: "Question Type"),
                  items: const [
                    DropdownMenuItem(
                        value: QuestionType.selectOne,
                        child: Text("Single Answer")),
                    DropdownMenuItem(
                        value: QuestionType.selectAll,
                        child: Text("Multiple Answer")),
                  ],
                  onChanged: (value) {
                    questionType = value!;
                  },
                  validator: (value) => value == null ? 'Field Required' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            backgroundColor:
                                Theme.of(context).appBarTheme.backgroundColor,
                            title: const Text("Enter your Answer"),
                            content:
                                StatefulBuilder(builder: (context, setState) {
                              return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    CustomTextField(
                                      iconData: Icons.question_answer,
                                      controller: _answerController,
                                      hintText: 'Enter Answer',
                                    ),
                                    SwitchListTile(
                                      title: const Text('Correct Answer'),
                                      value: correct,
                                      onChanged: (newValue) {
                                        setState(() {
                                          correct = newValue;
                                        });
                                      },
                                    ),
                                  ]);
                            }),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    var ans = Answer(
                                        answer: _answerController.text,
                                        correctAnswer: correct);
                                    _answers.add(ans);
                                    Navigator.of(context).pop();
                                    _answerController.clear();
                                    correct = false;
                                    _setState();
                                  },
                                  child: const Text("Submit")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _answerController.clear();
                                  },
                                  child: const Text("Cancel"))
                            ],
                          );
                        });

                    //print(_answers.toString());
                  },
                  child: const Text('Add Answer'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Adding Question')),
                    );
                    _saveForm(certID);
                    _questionController.clear();
                  }
                },
                child: const Text('Add Question'),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _answers.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_answers[index].answer),
                      subtitle: Text(
                          "Correct answer: ${_answers[index].correctAnswer}"),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              _answers.remove(_answers[index]);
                            });
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
