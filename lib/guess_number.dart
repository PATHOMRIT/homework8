import 'package:flutter/material.dart';
import 'package:homework8/game.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GUESS_NUMBER',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();
  var game = Game();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            border: Border.all(width: 10.0, color: Colors.green.shade50),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 75.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/guess_logo.png',
                        height: 100.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: [
                            Text(
                              'GUESS',
                              style: TextStyle(
                                  fontSize: 60.0, color: Colors.blue.shade200),
                            ),
                            Text(
                              'THE NUMBER',
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.blue.shade200),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green,
                      border: OutlineInputBorder(),
                      hintText: 'ทายเลข 1 ถึง ${game.getmaxRandom()}',
                    ),
                  ),
                  height: 100.0,
                  width: 400,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: SizedBox(
                    height: 75.0,
                    width: 150.0,
                    child: ElevatedButton(
                      child: Text('Guess',
                          style:
                          TextStyle(fontSize: 30.0, color: Colors.black)),
                      onPressed: () {
                        var input = _controller.text;
                        var inputNumber = int.tryParse(input);
                        String result = 'Result';
                        String error = 'Error';
                        String messageError =
                            'กรอกข้อมูลไม่ถูกต้อง ให้กรอกเฉพาะตัวเลขเท่านั้น';
                        if (inputNumber == null) {
                          showDialog(
                              context: context,
                              builder: (
                                  BuildContext contxet,
                                  ) {
                                return AlertDialog(
                                  title: Text(error),
                                  content: Text(messageError),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Ok')),
                                  ],
                                );
                              });
                        }
                        int resultNumber = game.doGuess(inputNumber!);
                        String messageResult;
                        if (resultNumber == -1) {
                          messageResult =
                          '$inputNumber น้อยเกินไปกรุณาลองใหม่';
                        } else if (resultNumber == 1) {
                          messageResult =
                          '$inputNumber มากเกินไปกรุณาลองใหม่';
                        } else {
                          messageResult =
                          '$inputNumber ถูกต้องครับ 🎉 คุณทายทั้งหมด ${game.getdoCount()} ครั้ง';
                        }
                        showDialog(context: context, builder: (BuildContext context, ) {
                          return AlertDialog(
                            title: Text(result),
                            content: Text(messageResult),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Ok')
                              ),
                            ],
                          );
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}