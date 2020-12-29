import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Number Game',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Game'),
        ),
        body: GameFun(),
        backgroundColor: Colors.grey[850],
      ),
    );
  }
}

class GameFun extends StatefulWidget {
  @override
  _GameFunState createState() => _GameFunState();
}

class _GameFunState extends State<GameFun> {
  final fieldText = TextEditingController();

  int firstNum = Random().nextInt(9);
  int secondNum = Random().nextInt(8) + 1;

  String operate = "+";

  int inputValue = 0;
  String nextBtn = "Submit";

  int score = 0;

// Change Number
  void changeNumber() {
    setState(() {
      if (operate == "/") {
        int tempFirstNum = Random().nextInt(9);
        int tempSecondNum = Random().nextInt(8) + 1;
        if (tempFirstNum % tempSecondNum == 0 &&
            (tempFirstNum / tempSecondNum is int)) {
          firstNum = tempFirstNum;
          secondNum = tempSecondNum;

          print('from sahi jagah if $firstNum and $secondNum');
        } else {
          secondNum = tempSecondNum;
          firstNum = secondNum * Random().nextInt(3);

          print('from sahi jagah else $firstNum and $secondNum');
        }
      } else if (operate == "-") {
        int tempFirstNum = Random().nextInt(9);
        int tempSecondNum = Random().nextInt(8) + 1;
        if (tempFirstNum - tempSecondNum < 0) {
          print('0 se km hai');
          firstNum = tempSecondNum;
          secondNum = tempFirstNum;
        } else {
          print('0 se jada hai');
          firstNum = tempFirstNum;
          secondNum = tempSecondNum;
        }
      } else {
        firstNum = Random().nextInt(9);
        secondNum = Random().nextInt(8) + 1;
      }
    });
  }

  // Change operator
  void changeOperator() {
    setState(() {
      int tempNum = Random().nextInt(4) + 1;
      if (tempNum == 1) {
        operate = "+";
      } else if (tempNum == 2) {
        operate = "-";
      } else if (tempNum == 3) {
        operate = "*";
      } else if (tempNum == 4) {
        operate = "/";
      }
    });
  }

  void checkAnswer() {
    if (operate == "+") {
      if (firstNum + secondNum == inputValue) {
        print('true');
        nextBtn = "Correct";
        score = score + 1;
      } else {
        print('false');
        nextBtn = "Incorrect";
      }
    } else if (operate == "-") {
      if (firstNum - secondNum == inputValue) {
        print('true');
        nextBtn = "Correct";
        score = score + 1;
      } else {
        print('false');
        nextBtn = "Incorrect";
      }
    } else if (operate == "*") {
      if (firstNum * secondNum == inputValue) {
        print('true');
        nextBtn = "Correct";
        score = score + 1;
      } else {
        print('false');
        nextBtn = "Incorrect";
      }
    } else if (operate == "/") {
      if (firstNum / secondNum == inputValue) {
        print('true');
        nextBtn = "Correct";
        score = score + 1;
      } else {
        print('false');
        nextBtn = "Incorrect";
      }
    }
  }

  void clearTextBox() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: EdgeInsets.only(right: 20, bottom: 30, top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '$firstNum',
                          style: TextStyle(color: Colors.white, fontSize: 60),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '$operate',
                          style: TextStyle(color: Colors.white, fontSize: 60),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '$secondNum',
                          style: TextStyle(color: Colors.white, fontSize: 60),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '=',
                          style: TextStyle(color: Colors.white, fontSize: 60),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white54, width: 2.0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 5.0),
                              ),
                              hintText: '',
                              hoverColor: Colors.white),
                          style: TextStyle(color: Colors.white, fontSize: 60),
                          // On change
                          onChanged: (text) {
                            inputValue = int.parse(text);
                            print(inputValue);
                            checkAnswer();
                            if (nextBtn == "Correct") {
                              changeOperator();
                              changeNumber();
                              clearTextBox();
                            }
                          },
                          controller: fieldText,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              color: Colors.grey[100],
                              // height: 50,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(left: 20),
                              child: Text(
                                'Score: $score',
                                style: TextStyle(
                                    color: Colors.green[900], fontSize: 30),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                              color: Colors.grey[100],
                              height: 60,
                              minWidth: 30,
                              child: Icon(Icons.refresh),
                              onPressed: () {
                                changeOperator();
                                changeNumber();
                                clearTextBox();
                                score = 0;
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
