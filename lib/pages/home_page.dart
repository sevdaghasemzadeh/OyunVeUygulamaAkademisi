import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:istanbul/pages/auth/login_page.dart';
import 'package:istanbul/pages/equation_solver_page.dart';
import 'package:istanbul/pages/history_page.dart';
import '../service/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  String output = "0";
  String firebaseOutput = "0";
  double numberInput = 0;
  String operator = "";
  bool isResultShown = false;

  void buttonPressed(String numberKey) {
    if (isResultShown) {
      output = "0";
      isResultShown = false;
    }

    if (numberKey == "trig"){

    }

    if (numberKey == "AC") {
      numberInput = 0;
      operator = "";
      output = "0";
    } else if (numberKey == "+/-") {
      if (!output.startsWith('-')) {
        output = "-" + output;
      } else {
        output = output.substring(1);
      }
    } else if (numberKey == "%") {
      numberInput = double.parse(output);
      output = (numberInput * 0.01).toString();
      numberInput = 0;
      operator = "";
      isResultShown = true;
    } else if (numberKey == "log") {
      numberInput = double.parse(output);
      output = log(numberInput).toString();
      numberInput = 0;
      operator = "";
      isResultShown = true;
    } else if (numberKey == "x^n") {
      numberInput = double.parse(output);
      operator = numberKey;
      output = "0";
    } else if (numberKey == "√") {
      numberInput = double.parse(output);
      output = sqrt(numberInput).toString();
      numberInput = 0;
      operator = "";
      isResultShown = true;
    } else if (numberKey == "+" ||
        numberKey == "/" ||
        numberKey == "*" ||
        numberKey == "-") {
      numberInput = double.parse(output);
      operator = numberKey;
      output = "0";
    } else if (numberKey == "=") {
      switch (operator) {
        case "+":
          firebaseOutput = "$numberInput + ${double.parse(output)}";
          output = (numberInput + double.parse(output)).toString();
          firebaseOutput += " = $output";
          addCalculationToDatabase(firebaseOutput);
          break;
        case "-":
          firebaseOutput = "$numberInput - ${double.parse(output)}";
          output = (numberInput - double.parse(output)).toString();
          firebaseOutput += " = $output";
          addCalculationToDatabase(firebaseOutput);
          break;
        case "*":
          firebaseOutput = "$numberInput * ${double.parse(output)}";
          output = (numberInput * double.parse(output)).toString();
          firebaseOutput += " = $output";
          addCalculationToDatabase(firebaseOutput);
          break;
        case "/":
          firebaseOutput = "$numberInput / ${double.parse(output)}";
          output = (numberInput / double.parse(output)).toString();
          firebaseOutput += " = $output";
          addCalculationToDatabase(firebaseOutput);
          break;
        case "x^n":
          firebaseOutput = "$numberInput^${double.parse(output)}";
          output = pow(numberInput, double.parse(output)).toString();
          firebaseOutput += " = $output";
          addCalculationToDatabase(firebaseOutput);
          break;
      }

      if (double.tryParse(output) != null) {
        double result = double.parse(output);
        if (result % 1 == 0) {
          output = result.toInt().toString();
        } else {
          output = result.toStringAsFixed(3).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
        }
      }

      numberInput = 0;
      operator = "";
      isResultShown = true;

    } else {
      if (output == "0" || output == "-0") {
        output = numberKey;
      } else {
        output += numberKey;
      }
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(215,151,94,1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(211,207,199,1),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(80, 50, 50, 60),
                child: Text('Quick Math', style: TextStyle(fontStyle: FontStyle.italic,) ),
              ),
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                authService.signOut();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
            ),
            ListTile(
              title: const Text('Calculation History'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const HistoryPage();
                }));
              },
            ),
            ListTile(
              title: const Text('Equation Solver'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const EquationSolver();
                }));
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(211,207,199,1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 100,
            width: 330,
            alignment: Alignment.centerRight,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                output,
                style: const TextStyle(
                    fontSize: 70,
                    color: Colors.white,
                    fontFamily: "Helvetica"
                ),
              ),
            ),
          ),
          const SizedBox(
              height: 15
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              iconButton(buttonPressed, "AC"),
              iconButton(buttonPressed, "+/-"),
              iconButton(buttonPressed, "%"),
              divideButton(buttonPressed),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              iconButton(buttonPressed, "log"),
              iconButton(buttonPressed, "x^n"),
              iconButton(buttonPressed, "√"),
              trigButton(buttonPressed),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              numberButton(buttonPressed, "7"),
              numberButton(buttonPressed, "8"),
              numberButton(buttonPressed, "9"),
              multiplyButton(buttonPressed),

            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              numberButton(buttonPressed, "4"),
              numberButton(buttonPressed, "5"),
              numberButton(buttonPressed, "6"),
              substractButton(buttonPressed)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              numberButton(buttonPressed, "1"),
              numberButton(buttonPressed, "2"),
              numberButton(buttonPressed, "3"),
              addButton(buttonPressed)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              zeroButton(buttonPressed),
              commaButton(buttonPressed),
              equalButton(buttonPressed),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class trigButton extends StatefulWidget {
  Function buttonPressed;
  trigButton(this.buttonPressed, {Key? key}) : super(key: key);

  @override
  State<trigButton> createState() => _trigButtonState();
}

class _trigButtonState extends State<trigButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
      child: ElevatedButton(
        onPressed: () {
          widget.buttonPressed("trig");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isHovered ? Colors.yellow : const Color.fromRGBO(215,151,94,1),
          minimumSize: const Size.fromRadius(40.0),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
        ),
        child: const Text(
          'Trig',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Helvetica',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}







class equalButton extends StatelessWidget {
  Function buttonPressed;
  equalButton(this.buttonPressed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(215,151,94,1),
          minimumSize: const Size.fromRadius(40.0),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20)),
      onPressed: () {
        buttonPressed("=");
      },
      child:const  Text(
        "=",
        style: TextStyle(
            fontSize: 36,
            fontFamily: 'Helvetica',
            color: Colors.white
        ),
      ),
    );
  }
}

class commaButton extends StatelessWidget {
  Function buttonPressed;
  commaButton(this.buttonPressed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        buttonPressed(".");
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(116,124,124,1),
          minimumSize: const Size.fromRadius(40.0),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20)),
      child: const Text(
        ".",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
            color: Colors.white
        ),
      ),
    );
  }
}

class zeroButton extends StatelessWidget {
  Function buttonPressed;
  zeroButton(this.buttonPressed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 86*2,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(116,124,124,1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
        ),
        onPressed: () {
          buttonPressed("0");
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: 34,
          width: 57*2,
          child: const Text(
            "0",
            style: TextStyle(
                fontSize: 36,
                fontFamily: 'Helvetica',
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}

class addButton extends StatelessWidget {
  Function buttonPressed;
  addButton(this.buttonPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          buttonPressed("+");
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(215,151,94,1),
            minimumSize: const Size.fromRadius(40.0),
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20)),
        child: const Text(
          style: TextStyle(
              fontSize: 40,
              fontFamily: 'Helvetica',
              color: Colors.white
          ),
          "+",

        )
    );
  }
}

class substractButton extends StatelessWidget {
  Function buttonPressed;
  substractButton(this.buttonPressed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          buttonPressed("-");
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(215,151,94,1),
            minimumSize: const Size.fromRadius(40.0),
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20)),
        child: const Text(
            style: TextStyle(
                fontSize: 40,
                fontFamily: 'Helvetica',
                color: Colors.white

            ),
            "-"
        )
    );
  }
}

class multiplyButton extends StatelessWidget {
  Function buttonPressed;
  multiplyButton(this.buttonPressed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          buttonPressed("*");
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(215,151,94,1),
            minimumSize: const Size.fromRadius(40.0),
            shape: const CircleBorder(),
            padding:const  EdgeInsets.all(20)),
        child: const  Text(
            style: TextStyle(
                fontSize: 35,
                fontFamily: 'Helvetica',
                color: Colors.white

            ),
            "x"
        )
    );
  }
}

class divideButton extends StatelessWidget {
  Function buttonPressed;
  divideButton(this.buttonPressed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          buttonPressed("/");
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(215,151,94,1),
            minimumSize: const Size.fromRadius(40.0),
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20)),
        child: const Text(
            style:const  TextStyle(
                fontSize: 30,
                fontFamily: 'Helvetica',
                color: Colors.white
            ),
            "÷"
        )
    );
  }
}

class iconButton extends StatefulWidget {
  Function buttonPressed;
  final String? iconName;

  iconButton(this.buttonPressed,
      this.iconName,{
        Key? key,
      }) : super(key: key);

  @override
  State<iconButton> createState() => _iconButtonState();
}

class _iconButtonState extends State<iconButton> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.buttonPressed(widget.iconName);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(250,248,245, 1),
          minimumSize: const Size.fromRadius(40.0),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20)),
      child: Text(
        widget.iconName!,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: 'Helvetica'
        ),
      ),
    );
  }
}

class numberButton extends StatefulWidget {
  Function buttonPressed;
  final String? numberKey;
  numberButton(this.buttonPressed, this.numberKey,{Key? key}) : super(key: key);

  @override
  State<numberButton> createState() => _numberButtonState();
}

class _numberButtonState extends State<numberButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.buttonPressed(widget.numberKey);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(116,124,124,1),
          minimumSize: const Size.fromRadius(40.0),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20)),
      child: Text(
        widget.numberKey!,
        style: const TextStyle(
          fontSize: 40,
          fontFamily: 'Helvetica',
          color: Colors.white
        ),
      ),
    );
  }
}

void addCalculationToDatabase(calculation) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  DocumentReference userRef = FirebaseFirestore.instance.collection('calculations').doc(uid);
  DocumentSnapshot userSnapshot = await userRef.get();
  if (userSnapshot.exists) {
    Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

    if (userData != null && userData.containsKey('calculations')) {
      List<dynamic> calculations = userData['calculations'];
      calculations.add(calculation);
      await userRef.update({
        'calculations': calculations,
      });
    } else {
      List<dynamic> calculations = [calculation];
      await userRef.set({
        'calculations': calculations,
      });
    }
  } else {
    List<dynamic> calculations = [calculation];
    await userRef.set({
      'calculations': calculations
    });
  }
}
