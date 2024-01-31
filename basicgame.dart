import 'dart:io';

import 'package:flutter/material.dart';
 
 class Game extends StatefulWidget{
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  static const String PLAYER_X = "X";
  static const String PLAYER_Y = "O";

  late String currentPlayer;
  late bool gameEnd;
  late List<String> occupied;


  @override
  void initState() {
    intializeGame();
    // TODO: implement initState
    super.initState();
  }

  void intializeGame(){
    currentPlayer = PLAYER_X;
  gameEnd = false;
  occupied = ["","","","","","","","",""];//9 empty places
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              _headerText(),
              _gameContainer(),
              _reStartbutton(),
              
          ],
        ),
      ),
    );
  }
  Widget _headerText(){
    return Column(
      children: [
        const Text("Tic Tac Teo",
        style: TextStyle(
          color: Colors.green,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        ),
        Text("$currentPlayer turn",
        style: TextStyle(
          color: Color.fromARGB(255, 1, 34, 1),
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        ),
      ],
    );
  }
  Widget _gameContainer(){
    return Container(
      height: MediaQuery.of(context).size.height/2,
      width: MediaQuery.of(context).size.width/2,
      margin: const EdgeInsets.all(8),
      child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
      itemCount: 9,
      itemBuilder: (context, int index){
        return _box(index);
      }),
    );
  }
Widget _box(int index){
  return InkWell(
    onTap: () {
      //on click box
      if(gameEnd || occupied[index].isNotEmpty){
        //return game is ended or game over
        return;

      }

     setState(() {
        occupied[index] = currentPlayer;
        changeTurn();
        checkForWinner();
        checkForDraw();
     });
    },
    child: Container(
      color: occupied[index].isEmpty?Colors.black26:occupied[index] == PLAYER_X?
      Colors.blue:
      Colors.orange,
      margin: const EdgeInsets.all(5),
      child: Center(
        child: 
        Text(occupied[index],
        style: const TextStyle(fontSize: 30),
        ),
        ),
    ),
  );
}
_reStartbutton(){
  return ElevatedButton(onPressed: (){
    setState(() {
      intializeGame();
    });
  }, child: const Text("Restart Game"));
}

changeTurn(){
  if(currentPlayer == PLAYER_X){
  currentPlayer = PLAYER_Y;
  }
  else{
    currentPlayer = PLAYER_X;
  }
}

checkForWinner(){
  //defining winning position
  List<List<int>> winningList = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6],
  ];
  for(var winningpos in winningList){
    String playerPosition0 = occupied[winningpos[0]];
    String playerPosition1 = occupied[winningpos[1]];
    String playerPosition2 = occupied[winningpos[2]];
    if(playerPosition0.isNotEmpty){
      if(playerPosition0 == playerPosition1 && playerPosition0 == playerPosition2){
        //all equal means player is won'
        showGameOverMessage("player $playerPosition0 is won");
        gameEnd = true;
        return;
      }

    }

  }
}
 checkForDraw(){
  if(gameEnd){
    return;
  }
  bool draw = true;
  for(var occupiedPlayer in occupied){
    if(occupiedPlayer.isEmpty){
    draw = false;
    }
  }
  if(draw){
    showGameOverMessage("draw");
     draw = true;
    
  }
 }


 showGameOverMessage(String message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text
      ("Game over \n $message",
      textAlign: TextAlign.center,
      style: const TextStyle(
      fontSize: 20,

    ),)),
  );
 }

}
 