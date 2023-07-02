import 'dart:math';

import 'package:flutter/material.dart';
import 'package:istanbul/pages/auth/login_page.dart';
import '../service/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  double numberInput = 0;
  String operator = "";
  String output = "0";
  bool isResultShown = false;

  buttonPressed(String numberKey) {
    if (isResultShown) {
      output = "0";
      isResultShown = false;
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
    } else if (numberKey == "x^2") {
      numberInput = double.parse(output);
      output = pow(numberInput, 2).toString();
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
          output = (numberInput + double.parse(output)).toString();
          break;
        case "-":
          output = (numberInput - double.parse(output)).toString();
          break;
        case "*":
          output = (numberInput * double.parse(output)).toString();
          break;
        case "/":
          output = (numberInput / double.parse(output)).toString();
          break;
        case "x^n":
          output = pow(numberInput, double.parse(output)).toString();
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Quick Math'),
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                authService.signOut();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
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
                style: TextStyle(
                    fontSize: 70,
                    color: Colors.white,
                    fontFamily: "Helvetica"
                ),
              ),
            ),
          ),
          SizedBox(
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
              iconButton(buttonPressed, "x^2"),
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


class trigButton extends StatelessWidget {
  Function buttonPressed;
  trigButton(this.buttonPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          buttonPressed("trg");
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(246,153,6, 1),
            minimumSize: const Size.fromRadius(40.0),
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20)),
        child: const Text(
            style:const  TextStyle(
                fontSize: 20,
                fontFamily: 'Helvetica'
            ),
            "Trig"
        )
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
          backgroundColor: const Color.fromRGBO(246,153,6, 1),
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
            fontFamily: 'Helvetica'
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
          backgroundColor: const Color.fromRGBO(49, 49, 49, 1),
          minimumSize: const Size.fromRadius(40.0),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20)),
      child: const Text(
        ".",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
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
          backgroundColor: const Color.fromRGBO(49, 49, 49, 1),
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
                fontFamily: 'Helvetica'
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
            backgroundColor: const Color.fromRGBO(246,153,6, 1),
            minimumSize: const Size.fromRadius(40.0),
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20)),
        child: const Text(
          style: TextStyle(
              fontSize: 40,
              fontFamily: 'Helvetica'
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
            backgroundColor: const Color.fromRGBO(246,153,6, 1),
            minimumSize: const Size.fromRadius(40.0),
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20)),
        child: const Text(
            style: TextStyle(
                fontSize: 40,
                fontFamily: 'Helvetica'
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
            backgroundColor: const Color.fromRGBO(246,153,6, 1),
            minimumSize: const Size.fromRadius(40.0),
            shape: const CircleBorder(),
            padding:const  EdgeInsets.all(20)),
        child: const  Text(
            style: TextStyle(
                fontSize: 35,
                fontFamily: 'Helvetica'
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
            backgroundColor: const Color.fromRGBO(246,153,6, 1),
            minimumSize: const Size.fromRadius(40.0),
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20)),
        child: const Text(
            style:const  TextStyle(
                fontSize: 30,
                fontFamily: 'Helvetica'
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
          backgroundColor: const Color.fromRGBO(159,159,159, 1),
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
          backgroundColor: const Color.fromRGBO(49, 49, 49, 1),
          minimumSize: const Size.fromRadius(40.0),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20)),
      child: Text(
        widget.numberKey!,
        style: const TextStyle(
          fontSize: 40,
          fontFamily: 'Helvetica',
        ),
      ),
    );
  }
}
