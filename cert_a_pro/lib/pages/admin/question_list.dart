import 'package:cert_a_pro/providers/question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionList extends StatefulWidget {
  final String certID;
  const QuestionList({super.key, required this.certID});

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    Provider.of<Questions>(context, listen: false).getQuestions(widget.certID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final questions = Provider.of<Questions>(context);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: questions.items.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(questions.items[index].question),
              //subtitle: item.buildSubtitle(context),
              trailing: IconButton(
                  onPressed: () {
                    questions.deleteQuestion(questions.items[index].id);
                    setState(() {
                    });
                  },
                  icon: const Icon(Icons.delete)),
            ),
          ),
        );
      },
    );
  }
}
