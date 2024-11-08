import 'package:flutter/material.dart';

void main() {
  runApp(TargetGameApp());
}

class TargetGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int target = 50; // Target number
  int sum = 0; // Current sum of player
  int step = 1; // Current step value
  int turns = 0; // Number of turns taken by the player
  bool hasWon = false; // Win status

  void _resetGame() { // Reset the game
    setState(() {
      target = (20 + (target * 1.5).toInt()) % 100; // Randomly set a new target
      sum = 0;
      step = 1;
      turns = 0;
      hasWon = false;
    });
  }

  void _incrementTurn() {
    if (!hasWon) {
      setState(() {
        turns += 1;
      });
    }
  }

  void _updateStep(int change) {
    _incrementTurn();
    setState(() {
      step += change;
      if (step < 1) step = 1;
    });
  }

  void _multiplyOrDivideStep(bool multiply) {
    _incrementTurn();
    setState(() {
      step = multiply ? step * 2 : (step / 2).floor(); // Divide step by 2 and take the floor value
      if (step < 1) step = 1;
    });
  }

  void _updateSum(bool increase) {
    _incrementTurn();
    setState(() {
      sum += increase ? step : -step; // Increase or decrease sum by step value
      //reset step value
      step = 1;
      if (sum == target) {
        hasWon = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reach the Target')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TargetDisplay(target: target), // Stateless Widget #1
            StepControls(
              step: step,
              onIncrease: () => _updateStep(1),
              onDecrease: () => _updateStep(-1),
              onMultiply: () => _multiplyOrDivideStep(true),
              onDivide: () => _multiplyOrDivideStep(false),
            ), // Stateless Widget #2
            SumDisplay(sum: sum), // Stateless Widget #3
            if (hasWon)
              Text(
                'Congratulations! You reached the target in $turns turns!',
                style: TextStyle(fontSize: 24, color: Colors.green),
                textAlign: TextAlign.center,
              ),
            SumControls(
              onIncrease: () => _updateSum(true),
              onDecrease: () => _updateSum(false),
            ), // Stateless Widget #4
            Spacer(),
            Text('Turns: $turns', style: TextStyle(fontSize: 18)),
            ResetButton(onReset: _resetGame), // Stateless Widget #5
          ],
        ),
      ),
    );
  }
}

class TargetDisplay extends StatelessWidget {
  final int target;

  TargetDisplay({required this.target});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Target: $target',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }
}

class StepControls extends StatelessWidget {
  final int step;
  final VoidCallback onIncrease; // VoidCallback is a function that takes no arguments and returns void
  final VoidCallback onDecrease;
  final VoidCallback onMultiply;
  final VoidCallback onDivide;

  StepControls({
    required this.step, // Required parameter
    required this.onIncrease,
    required this.onDecrease,
    required this.onMultiply,
    required this.onDivide,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Step: $step',
          style: TextStyle(fontSize: 24),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.call_split),
              onPressed: onDivide,
            ),
            IconButton(
              icon: Icon(Icons.exposure_minus_1),
              onPressed: onDecrease,
            ),

            IconButton(
              icon: Icon(Icons.exposure_plus_1),
              onPressed: onIncrease,
            ),
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: onMultiply,
            ),
          ],
        ),
      ],
    );
  }
}

class SumDisplay extends StatelessWidget {
  final int sum;

  SumDisplay({required this.sum});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sum: $sum',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }
}

class SumControls extends StatelessWidget {
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  SumControls({
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onDecrease,
          child: Text('- Step'),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: onIncrease,
          child: Text('+ Step'),
        ),
      ],
    );
  }
}

class ResetButton extends StatelessWidget {
  final VoidCallback onReset;

  ResetButton({required this.onReset});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onReset,
      child: Text('Reset Game'),
    );
  }
}
