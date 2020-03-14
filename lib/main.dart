import 'package:flutter/material.dart';
import 'package:quizzler/QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());
QuizBrain quizBrain = QuizBrain();

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
  int score = 0;
  List<Icon> scoreKeeper = [];

  var alertStyle = AlertStyle(
      isCloseButton: false,
      isOverlayTapDismiss: false,
      backgroundColor: Colors.blueGrey[500]);

  void onAnswer(bool userAnswer) {
    quizBrain.isAnswer(userAnswer)
        ? setState(() {
            score++;
            scoreKeeper.add(Icon(Icons.check, color: Colors.green));
          })
        : setState(() => scoreKeeper.add(Icon(Icons.close, color: Colors.red)));
    quizBrain.nextQuestion();
    if (quizBrain.isFinalQuestion()) {
      Alert(
              context: context,
              title: 'Quiz Complete!',
              desc: 'Your Score: $score/${quizBrain.getNumberOfQuestions()}',
              style: alertStyle)
          .show();
      resetState();
    }
  }

  void resetState() {
    quizBrain.reset();
    setState(() {
      score = 0;
      scoreKeeper = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'BalooChettan2',
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  fontFamily: 'BalooChettan2',
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0)),
              onPressed: () => onAnswer(true),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontFamily: 'BalooChettan2',
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0)),
              onPressed: () => onAnswer(false),
            ),
          ),
        ),
        Row(children: scoreKeeper)
      ],
    );
  }
}
