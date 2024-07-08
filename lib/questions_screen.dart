import 'package:flutter/material.dart';
import 'package:flutter_fun_quiz/answer_button.dart';
import 'package:flutter_fun_quiz/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget{
  const QuestionsScreen({
    super.key,
    required this.onSelectedAnswer
  });

  final void Function(String answer) onSelectedAnswer;
  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen>{
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer){
    // currentQuestionIndex = currentQuestionIndex+1;
    // currentQuestionIndex +=1;

    widget.onSelectedAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex ++;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 201, 153, 251),
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
               textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30,),
            ...currentQuestion.getShuffledAnswer().map((answer){
            return AnswerButton(
                answerText: answer,
                onTap: (){
                  answerQuestion(answer);
                }
              );
            }),
          ],
        ),
      ),
    );
  }
}