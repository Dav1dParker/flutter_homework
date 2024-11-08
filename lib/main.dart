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
  int target = 50;
  int sum = 0;
  int step = 1;
  int turns = 0;
  bool hasWon = false;

  void _resetGame() {
    setState(() {
      target = (20 + (target * 1.5).toInt()) % 100;
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

  void _changeStep(int newStep) {
    setState(() {
      step = newStep < 1 ? 1 : newStep;
    });
  }

  void _updateSum(int delta) {
    if (hasWon) return;

    setState(() {
      sum += delta;
      _incrementTurn();
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
              onStepChange: _changeStep,
            ), // Stateful Widget #2
            SumDisplay(sum: sum), // Stateless Widget #3
            SumControls(
              step: step,
              onUpdateSum: _updateSum,
            ), // Stateless Widget #4
            Spacer(),
            TurnCounter(turns: turns), // Stateless Widget #5
            if (hasWon)
              WinMessage(turns: turns), // Stateful Widget #6 (Conditional)
            ResetButton(onReset: _resetGame), // Stateless Widget #7
          ],
        ),
      ),
    );
  }
}

// 1. TargetDisplay (Stateless) - Displays the target number
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

// 2. StepControls (Stateful) - Manages step value changes (increased or decreased by 1, multiplied or divided by 2)
class StepControls extends StatefulWidget {
  final int step;
  final ValueChanged<int> onStepChange;

  StepControls({required this.step, required this.onStepChange});

  @override
  _StepControlsState createState() => _StepControlsState();
}

class _StepControlsState extends State<StepControls> {
  late int _currentStep;

  @override
  void initState() {
    super.initState();
    _currentStep = widget.step;
  }

  void _incrementStep() {
    setState(() {
      _currentStep += 1;
      widget.onStepChange(_currentStep);
    });
  }

  void _decrementStep() {
    setState(() {
      _currentStep = (_currentStep - 1).clamp(1, _currentStep);
      widget.onStepChange(_currentStep);
    });
  }

  void _multiplyStep() {
    setState(() {
      _currentStep *= 2;
      widget.onStepChange(_currentStep);
    });
  }

  void _divideStep() {
    setState(() {
      _currentStep = (_currentStep / 2).floor().clamp(1, _currentStep);
      widget.onStepChange(_currentStep);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Step: $_currentStep',
          style: TextStyle(fontSize: 24),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.exposure_minus_1),
              onPressed: _decrementStep,
            ),
            IconButton(
              icon: Icon(Icons.call_split),
              onPressed: _divideStep,
            ),
            IconButton(
              icon: Icon(Icons.exposure_plus_1),
              onPressed: _incrementStep,
            ),
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: _multiplyStep,
            ),
          ],
        ),
      ],
    );
  }
}

// 3. SumDisplay (Stateless) - Displays the current sum
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

// 4. SumControls (Stateless) - Provides controls to increase or decrease sum by step
class SumControls extends StatelessWidget {
  final int step;
  final ValueChanged<int> onUpdateSum;

  SumControls({required this.step, required this.onUpdateSum});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => onUpdateSum(-step),
          child: Text('- Step'),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () => onUpdateSum(step),
          child: Text('+ Step'),
        ),
      ],
    );
  }
}

// 5. TurnCounter (Stateless) - Displays the number of turns taken
class TurnCounter extends StatelessWidget {
  final int turns;

  TurnCounter({required this.turns});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Turns: $turns',
      style: TextStyle(fontSize: 18),
    );
  }
}

// 6. WinMessage (Stateful) - Displays a congratulatory message if the player reaches the target
class WinMessage extends StatefulWidget {
  final int turns;

  WinMessage({required this.turns});

  @override
  _WinMessageState createState() => _WinMessageState();
}

class _WinMessageState extends State<WinMessage> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Congratulations! You reached the target in ${widget.turns} turns!',
      style: TextStyle(fontSize: 24, color: Colors.green),
      textAlign: TextAlign.center,
    );
  }
}

// 7. ResetButton (Stateless) - Resets the game
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
