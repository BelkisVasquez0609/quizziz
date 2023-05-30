import 'package:flutter/material.dart';
import 'package:quizzis_belkis_vasquez_1085273/quiz_brain.dart';


QuizzBrain quiz = QuizzBrain();
List<Widget> scoreKeeper = [];
int valid_cuestion = 0;

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quiz.getQuestionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),Expanded(
            child: quiz.lastQuestion() ? Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)
                ),
                child: Text(
                  'Empezar de Nuevo',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    quiz.restartQuestions();
                    scoreKeeper = [];
                    valid_cuestion = 0;
                  });
                },
              ),
            ) : Icon(Icons.repeat, color: Colors.white24,)
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green)
              ),
              child: Text(
                'Verdadero',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                if (!quiz.lastQuestion()) {
                  questionValidator(true);
                }
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red)
              ),
              child: Text(
                'Falso',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                if (!quiz.lastQuestion()) {
                  questionValidator(false);
                }
              },
            ),
          ),
        ),
        Wrap(
          children: scoreKeeper,
        ),
        //TODO: Add a Row here as your score keeper
      ],
    );
  }

  void questionValidator(bool selected) {
    bool correctAnswer = quiz.getQuestionAnswer;
    const iconSize = 31.0;
    if (correctAnswer == selected){
      scoreKeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
            size: 50.5,
          )
      );
      valid_cuestion++;
    }
    else
    {
      scoreKeeper.add(
          Icon(
            Icons.close,
            color: Colors.redAccent,
            size: 50.5,
          )
      );
    }
    setState(() {
      quiz.nextQuestion();
      if (quiz.lastQuestion()){
        _showMyDialog();
      }
    });
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¡Felicidades!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Has completado el juego'),
                Text('Tu puntuación es de (${valid_cuestion}/12) ptos'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}