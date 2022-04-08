import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const GuessNumber());
}

class GuessNumber extends StatelessWidget {
  const GuessNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  int generatedNumber = Random().nextInt(100);
  String buttonTitle = 'GUESS';
  String guessText = '';
  String hintText = '';

  int? generateRandom() {
    Random random = Random();
    int generatedNumber = random.nextInt(100);
    return generatedNumber;
  }

  alertDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('You guessed right!'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Try again!'),
              onPressed: () {
                Navigator.pop(context);
                generatedNumber = Random().nextInt(100);
                _controller.clear();
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
                _controller.clear();
                generatedNumber = Random().nextInt(100);
                buttonTitle = 'Reset';
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Guess my number'),
        ),
        body: Column(children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 6.0, right: 6.0, top: 8.0, bottom: 16.0),
            child: Text("I'm thinking of a number between 1 and 100.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                )),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "It's your turn to guess my number!",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          Text(guessText, style: const TextStyle(fontSize: 36.0, color: Colors.blueGrey)),
          Text(hintText, style: const TextStyle(fontSize: 36.0, color: Colors.blueGrey)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 32.0),
                    child: Text(
                      'Try a number!',
                      style: TextStyle(fontSize: 28.0, color: Colors.blueGrey),
                    ),
                  ),
                  TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(),
                  ),
                  Builder(builder: (context) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          onPrimary: Colors.black,
                        ),
                        onPressed: () {
                          final int input = int.parse(_controller.text);
                          setState(() {
                            if (input < generatedNumber) {
                              buttonTitle = 'GUESS';
                              guessText = 'You tried $input';
                              hintText = 'Try higher!';
                            } else if (input == generatedNumber) {
                              guessText = 'You tried $input';
                              hintText = 'You guess right!';
                              alertDialog(context, 'It was $generatedNumber');
                            } else {
                              buttonTitle = 'GUESS';
                              guessText = 'You tried $input';
                              hintText = 'Try lower!';
                            }
                          });
                        },
                        child: Text(buttonTitle));
                  })
                ],
              ),
            ),
          )
        ], crossAxisAlignment: CrossAxisAlignment.center),
      ),
    );
  }
}
