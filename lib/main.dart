
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Color textColor = Colors.white;

  List<Icon> scoreKeeper = [];

  void checkAnswer(bool pickedAnswer){

    bool correctAnswer = quizBrain.getQuestionAnswer();

    if(quizBrain.nextQuestion()) {
      setState(() {


      if (pickedAnswer == correctAnswer){
        print("user got it right");
        scoreKeeper.add(Icon(Icons.check, color: Colors.green,));

      } else {
        print("user got it wrong");

        scoreKeeper.add(Icon(Icons.close, color: Colors.red,));
      }
      quizBrain.nextQuestion();
      });
    } else {
      Alert(context: context, title: "Finished!", desc: "You've reached the end of this quiz! Follow my insta @kaegenk for more!").show();
    };

  }
  @override

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              quizBrain.getQuestionText(),
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor, fontSize: 25, ),
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Text("False"),
              onPressed: () {
                print("Elevated Button has been pressed");
             checkAnswer(false);

              },
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text("True"),
              onPressed: () {
                print("Elevated Button has been pressed");
                checkAnswer(true);

              },
            ),
          ),
        ),

        //TODO: Add a Row here as your score keeper
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
