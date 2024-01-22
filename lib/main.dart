import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Wealth Assistant',
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String? total;
String? estimatedReturn;
String? investedAmount;

List<bool> _selection = [true, false];



class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Padding(
              padding: EdgeInsets.only(bottom:20.0),
              child: Text('SIP Calculator',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 69, 192),
                  )),
            ),
            ToggleButtons(
              isSelected: _selection,
              onPressed: updateSelection,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Monthly'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Lumpsum'),
                ),
              ],
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 20.0, right: 50.0, bottom: 20.0),
                    child: Text(
                      'Investment \nAmount',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'i.e. : ₹ 100',
                          hintStyle: TextStyle(
                            color: Colors.black26,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Text(
                      'Expected Return \nRate (p.a)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: controller1,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'i.e. : 12 %',
                          hintStyle: TextStyle(
                            color: Colors.black26,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 20.0, bottom: 20.0, right: 40.0),
                    child: Text(
                      'Time Period',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: controller2,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'i.e. : 10 Yr',
                          hintStyle: TextStyle(
                            color: Colors.black26,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                onPressed: totalReturn,
                style: TextButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                child: const Text('Calculate'),
              ),
            ),
            if(total!=null)
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(
                'Total Principle Amount: ₹$investedAmount',
                style: const TextStyle(fontSize: 20),
                       ),
             ),
            if(total!=null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Estimated Return: ₹$estimatedReturn',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            if(total!=null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total Value: ₹$total',
                style: const TextStyle(fontSize: 20),
              ),
            )
          ]),
        ),
      ),
    );
  }


  void updateSelection(int selectedIndex){
  setState((){
  for(int i=0;i<_selection.length;i++){
    _selection[i]= selectedIndex == i;
  }
  });
  }

  
  //function to calculate total amount
  void totalReturn(){
    final principleAmount=double.parse(controller.text);
    final expectedRR=double.parse(controller1.text);
    final monthlyRR=expectedRR/12;
    final periodicRR=monthlyRR/100;
    final timePeriod=double.parse(controller2.text);
    final numberOfPayments=timePeriod*12;
    final totalAmount=_selection[0]? principleAmount*((pow(1+periodicRR,numberOfPayments)-1)/periodicRR)*(1+periodicRR): principleAmount+principleAmount*expectedRR*timePeriod/100;
    setState(() {
      total=totalAmount.toStringAsFixed(0);
      estimatedReturn=(totalAmount-principleAmount).toStringAsFixed(0);
      investedAmount=_selection[0]? (principleAmount*numberOfPayments).toStringAsFixed(0): principleAmount.toStringAsFixed(0);
    });
  }


}
