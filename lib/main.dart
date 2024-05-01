import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(background: Colors.white),
      ),
      home: const BMICalculatorPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class BMICalculatorPage extends StatefulWidget {
  const BMICalculatorPage({super.key, required this.title});

  final String title;

  @override
  State<BMICalculatorPage> createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  TextEditingController ftController = TextEditingController();
  TextEditingController inController = TextEditingController();
  TextEditingController wtController = TextEditingController();
  var bmiResult = '';
  var bgColor;
  var txtColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.deepPurple[900],
          title: const Text(
            'BMI Calculator',
            style: TextStyle(color: Colors.white),
          ),
          leading: const Icon(
            Icons.menu_rounded,
            size: 35,
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                size: 35,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_outlined,
                size: 35,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Container(
          color: bgColor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                'BMI Calculator',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 35,
                    letterSpacing: .5,
                  ),
                ),
              ),
              Material(
                elevation: 10,
                child: TextField(
                  controller: wtController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Enter your weight (in Kilograms)'),
                    prefixIcon: Icon(
                      Icons.monitor_weight_outlined,
                      size: 35,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Material(
                elevation: 10,
                child: TextField(
                  controller: ftController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Enter your height (in Feet)'),
                    prefixIcon: Icon(
                      Icons.height,
                      size: 40,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Material(
                elevation: 10,
                child: TextField(
                  controller: inController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Enter your height (in inches)'),
                    prefixIcon: Icon(
                      Icons.height,
                      size: 40,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.orange;
                    }
                    return Colors.purple;
                  }),
                ),
                onPressed: () {
                  var wt = wtController.text.toString();
                  var ft = ftController.text.toString();
                  var inch = inController.text.toString();

                  if (wt != '' && ft != '' && inch != '') {
                    var iWt = int.parse(wt);
                    var iFt = int.parse(ft);
                    var iIn = int.parse(inch);

                    var tInch = (iFt * 12) + iIn;

                    var tCm = tInch * 2.54;

                    var tM = tCm / 100;

                    var bmi = iWt / (tM * tM);

                    var msg = '';

                    if(bmi>25)
                      {
                        msg = 'You are overweight!';
                        bgColor = Colors.orange[300];
                        txtColor = Colors.red;
                      }
                    else if (bmi < 18)
                      {
                        msg = 'You are underweight!';
                        bgColor = Colors.red[400];
                        txtColor = Colors.red;
                      }
                    else
                      {
                        msg = 'You are healthy.';
                        bgColor = Colors.green[300];
                        txtColor = Colors.green[900];
                      }

                    setState(() {
                      bmiResult = 'Your BMI is ${bmi.toStringAsFixed(2)} \n $msg';

                    });

                  } else {
                    setState(() {
                      bmiResult = 'Please fill all the required blanks!!';
                    });
                  }
                },
                child: const Text(
                  'Calculate',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              
              Text(
                bmiResult,
                style: GoogleFonts.barlow(fontSize: 20, color: txtColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
