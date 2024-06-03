import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/screens/correction.dart';
import 'package:quiz/screens/home.dart';
import '../components/colors.dart';
import '../controllers/progress_bar_controller.dart';

class Score extends StatelessWidget {
  final String pseudo;
  const Score({Key? key, required this.pseudo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProgressController _qnController = Get.find<ProgressController>();
    int score = _qnController.calculateScore();
    bool passed = score >= 75;

    String message = passed
        ? "Félicitations, vous avez réussi le test de préparation au permis de conduire !"
        : "Vous n'avez pas réussi le test pour le moment. Continuez à pratiquer et à réviser pour améliorer vos chances de réussite.";

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/x.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 100,),
              Text(
                "Score",
                style: Theme.of(context).textTheme.headline3?.copyWith(color: KSecondaryColor),
              ),
              Image(image: AssetImage(passed ? "lib/assets/images/win-removebg-preview.png" : "lib/assets/images/lose1-removebg-preview.png")),
              Text(
                passed ? "Félicitation $pseudo" : "Oups $pseudo",
                style: Theme.of(context).textTheme.headline5?.copyWith(color: KSecondaryColor),
              ),
              Text(
                "Score : $score/100",
                style: Theme.of(context).textTheme.headline4?.copyWith(color: KSecondaryColor),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.all(50),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: passed ? Colors.green : Colors.red),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              /*ElevatedButton(
                  onPressed: () {
                    _qnController.resetController();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: Text("Reprendre le Quiz")
              ),*/
              Spacer(),
            ],
          )
        ],
      ),
    );
  }
}

