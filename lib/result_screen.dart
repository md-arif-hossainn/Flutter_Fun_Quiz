import 'package:flutter/material.dart';
import 'package:flutter_fun_quiz/question_summary.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.chosenAnswer, required this.onRestart});

  final List<String> chosenAnswer;
  final void Function() onRestart;

  List<Map<String,Object>> getSummaryData(){
    final List<Map<String,Object>> summary = [];

    /// i++ or i+1 both are same.
    for(var i = 0; i < chosenAnswer.length; i++){
      summary.add({
        'question_index': i,
         'question' : questions[i].text,
         'correct_answer': questions[i].answers[0],
         'user_answer' : chosenAnswer[i],
      });
    }
    return summary;
}
  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestion = summaryData.where((data){
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
        width: double.infinity,
        child: Container(
        margin: const EdgeInsets.all(40),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You answered $numCorrectQuestion out of $numTotalQuestions question correctly!',
                  style: GoogleFonts.lato(
                    color: const Color.fromARGB(255,237,223,252),
                    fontSize: 24,
                  ),
              ),
              const SizedBox(height: 30,),
              QuestionSummary(summaryData),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                  onPressed: onRestart,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Restart Quiz !')
              )
            ],
          ),
        )
      )
    );
  }
}
