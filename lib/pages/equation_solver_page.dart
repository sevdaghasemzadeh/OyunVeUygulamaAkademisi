import 'package:flutter/material.dart';

class EquationSolver extends StatefulWidget {
  const EquationSolver({super.key});

  @override
  State<EquationSolver> createState() => _EquationSolverState();
}

class _EquationSolverState extends State<EquationSolver> {
  String output = "0";
  String firebaseOutput = "0";
  double numberInput = 0;
  String operator = "";
  bool isResultShown = false;
  String solution = "";
  TextEditingController controllerForX = new TextEditingController();
  TextEditingController controllerForNumber = new TextEditingController();



  void buttonPressed(String numberKey) {
    if (numberKey == "submit" &&
        (controllerForX.text.isNotEmpty || controllerForNumber.text.isNotEmpty)) {
      // Submit'e basıldığında en az bir TextField doluysa denklemi yazdır
      String xText = controllerForX.text.isNotEmpty ? controllerForX.text : "0";
      String numberText = controllerForNumber.text.isNotEmpty ? controllerForNumber.text : "0";
      String equation = "${controllerForX.text}x + ${controllerForNumber.text}";
      double xValue = double.parse(xText);
      double numberValue = double.parse(numberText);
      double solutionValue = (-numberValue / xValue);
      solution = solutionValue.toStringAsFixed(2);
      controllerForX.clear();
      controllerForNumber.clear();
      controllerForX.text = solution;
    } else if (numberKey == "clear") {
      // Clear'a basıldığında her şeyi sil
      controllerForX.clear();
      controllerForNumber.clear();
      solution = "";
    } else {
      // Herhangi bir TextField boşsa ve karakter sınırına ulaşılmamışsa, tuş değerini boş olmayan TextFielde ekleyin
      if (controllerForX.text.isEmpty && controllerForX.text.length < 3) {
        controllerForX.text = controllerForX.text + numberKey;
      } else if (controllerForNumber.text.isEmpty && controllerForNumber.text.length < 3) {
        controllerForNumber.text = controllerForNumber.text + numberKey;
      }
    }
  }

//      String equation = "${controllerForX.text}x + ${controllerForNumber.text}";

  @override
  void dispose(){
    controllerForX.dispose();
    controllerForNumber.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 100,
              width: 330,
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          textAlign: TextAlign.center,
                          controller: controllerForX,
                          style: const TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontFamily: "Helvetica"
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          textAlign: TextAlign.center,
                          controller: controllerForNumber,
                          style: const TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontFamily: "Helvetica"
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
                height: 15
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
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                submitButton(buttonPressed)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                clearButton(buttonPressed)
              ],
            ),
          ],
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
      width: 86*2.3,
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
          width: 57*2.35,
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
            color: Colors.white
        ),
      ),
    );
  }
}


class submitButton extends StatelessWidget {
  Function buttonPressed;
  submitButton(this.buttonPressed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 86*3.73,
      height: 75,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(246,153,6, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
        ),
        onPressed: () {
          buttonPressed("submit");
        },
        child: Container(
          alignment: Alignment.center,
          child: const Text(
            "Submit",
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


class clearButton extends StatelessWidget {
  Function buttonPressed;
  clearButton(this.buttonPressed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 86*3.73,
      height: 75,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(246,153,6, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
        ),
        onPressed: () {
          buttonPressed("clear");
        },
        child: Container(
          alignment: Alignment.center,
          child: const Text(
            "Clear",
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