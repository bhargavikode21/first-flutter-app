import 'package:firstapp/buttonValues.dart';
import 'package:flutter/material.dart';



class CalculatorScreen extends StatefulWidget{

  const CalculatorScreen({super.key});
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>{
  String number1 = ""; //value
  String operand = "";//+ -* /%
  String number2  = "";//value
 
  Widget build(BuildContext context){
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            
            children: [
            // output
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: Text("$number1$operand$number2".isEmpty?"0":"$number1$operand$number2",
                  style:TextStyle(
                    fontSize: 48,
                    fontWeight:FontWeight.bold,  
                  ),
                  textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            // buttons
            Wrap(
              children: Btn.buttonValues.map(
                (value) => SizedBox(
                  width: screenSize.width/4,
                  height: screenSize.width/5,
                  child: buildbutton(value)),).toList(),
            )
          ],
          ),
        ),
    );

  }

  Widget buildbutton(value)
  {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: 
          const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
          borderRadius: BorderRadius.circular(100),),
        child: InkWell( 
          onTap: () => onBtnTap(value),
          child: Center(
            child: Text(
              value,style: 
              TextStyle(
                fontWeight: FontWeight.bold,fontSize: 20,),
            ),
            ),
        ),
      ),
    );  
  }
// ######
void onBtnTap(String value){
if(value == Btn.del){
  delete();
  return;
}
if(value == Btn.clr){
  clearAll();
  return;
}
if(value == Btn.percantage){
  percantagevalue();
  return;
}
if(value == Btn.calcula){
  calculate();
  return;
}

 appendValue(value);
}
// #####
void calculate(){
  if(number1.isEmpty) return;
  if(operand.isEmpty) return;
  if(number2.isEmpty) return;
  final double  num1 = double.parse(number1);
  final double  num2 = double.parse(number2);
  var result = 0.0;
  switch(operand){
    case Btn.addition:
    result = num1+num2;
    break;
    case Btn.subtraction:
    result = num1 - num2;
    break;
    case Btn.multiply:
    result = num1 * num2;
    break;
    case Btn.division:
    result = num1 / num2;
    break;
    default:
  }

  setState(() {
    number1 = "$result";
    if(number1.endsWith("number2")){
      number1 = number1.substring(0,number1.length-6);
    }
    if(number1.endsWith(".0")){
      number1 = number1.substring(0,number1.length-2);
    }
    operand = "";
    number2 = "";
  });
}

// ####
void percantagevalue(){
  if(number1.isEmpty&& operand.isNotEmpty&& number2.isNotEmpty){
    // our eqn is res = number1 operand number2
    // final res = number1 operand number2;
    calculate();
  }
  if(operand.isNotEmpty){
    return;
  }
  final number = double.parse(number1);


  setState(() {
    number1 = "${(number / 100)}";
    operand = "";
    number2 = "";
  });
}

// #####
//clear all input values given by users
void clearAll(){
  setState(() {
    number1 = "";
    operand = "";
    number2 = "";
  
  });
}

//#####
void delete(){
  if(number2.isNotEmpty)
  {
    number2 = number2.substring(0,number2.length -1);
  }
  else if(operand.isNotEmpty){
  operand = "";
  }else if(number1.isNotEmpty){
  number1 = number1.substring(0,number1.length -1);
  }
  setState(() {
    
  });

}
//###
void appendValue(String value){
   if(value!= Btn.dot&&int.tryParse(value)== null){
    if(operand.isNotEmpty&&number2.isNotEmpty){
      // calculate' equation before assignimg new value
      calculate();
    }
    operand = value;
  }
  else if(number1.isEmpty|| operand.isEmpty){
    if(value==Btn.dot && number1.contains(Btn.dot))return;
    if(value==Btn.dot && (number1.isEmpty || number1 == Btn.dot))
    {
value = "0.";//for decimal points
    }
    
    number1 += value;

  }
  else if(number2.isEmpty|| operand.isNotEmpty){
    if(value==Btn.dot && number2.contains(Btn.dot))return;
    if(value==Btn.dot && (number2.isEmpty || number2 == Btn.dot))
    {
value = "0.";//for decimal point
    }
    
    number2 += value;

  }
  setState((){});
}


  // #######
Color getBtnColor(value){
  return[Btn.del,
        Btn.clr].contains(value)?Color.fromARGB(255, 62, 69, 99):
        [Btn.addition,
        Btn.subtraction,
        Btn.multiply,
        Btn.division, 
        Btn.percantage,
        Btn.allclear,
        Btn.calcula].contains(value)?Color.fromARGB(255, 20, 53, 73):Color.fromARGB(255, 80, 96, 114);
}

}
