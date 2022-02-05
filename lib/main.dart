import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess_Number',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

  static const buttonSize = 55.0;
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  var game = Game();
  String alertMessage = 'ทายเลข 1 ถึง ${Game().getmaxRandom()}';

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
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/guess_logo.png', width: 125.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('GUESS',
                              style: TextStyle(
                                  fontSize: 50.0, color: Colors.blue)),
                          Text(
                            'THE NUMBER',
                            style: TextStyle(fontSize: 25.0, color: Colors.blue.shade200),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _input,
                  style: TextStyle(fontSize: 50.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  alertMessage,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 1; i < 4; i++) _buildBotton2(num: i),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 4; i < 7; i++) _buildBotton2(num: i),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 7; i < 10; i++) _buildBotton2(num: i),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBotton2(num: -2),
                  _buildBotton2(num: 0),
                  _buildBotton2(num: -1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0, top: 25.0),
                    child: SizedBox(
                      height: 40.0,
                      width: 120.0,
                      child: ElevatedButton(
                        child: Text('Guess',
                            style:
                                TextStyle(fontSize: 25.0, color: Colors.black)),
                        onPressed: () {
                          var guess = int.tryParse(_input!);
                          int result = game.doGuess(guess!);
                          setState(() {
                            if (result == 1) {
                              _input = '';
                              alertMessage = '$guess : มากเกินไป';
                            } else if (result == -1) {
                              _input = '';
                              alertMessage = '$guess : น้อยเกินไป';
                            } else {
                              alertMessage =
                                  '$guess : ถูกต้อง 🎉 (ทาย ${game.getdoCount()} ครั้ง)';
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  String _input = '';
  Widget _buildBotton2({int? num}) {
    Widget? child;
    BoxDecoration? boxDecoration = BoxDecoration(
      shape: BoxShape.rectangle
      border: Border.all(
        color: Colors.greenAccent,
        width: 3.0,
      ),
        borderRadius: BorderRadius.circular(16.0),
    );

    if (num == -1)
      child = Icon(
        Icons.backspace_outlined,
        size: 25.0,
      );
    else if (num == -2) {
      child = Text(
        'X',
        style: TextStyle(fontSize: 20.0),
      );
    } else {
      child = Text(
        '${num}',
        style: TextStyle(fontSize: 20.0),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.green.shade100,
        child: InkWell(
          onTap: () {
            setState(() {
              if (num == -1)
                _input = _input.substring(0, _input.length - 1);
              else if (num != -2 && _input.length < 3)
                _input += "$num";
              else if (num == -2) _input = '';
            });
          },
          child: Container(
            width: HomePage.buttonSize,
            height: HomePage.buttonSize,
            decoration: boxDecoration,
            alignment: Alignment.center,
            child: child,
            //color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
