import 'package:flutter/material.dart';
import 'package:quiz/screens/quiz.dart';

import '../components/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _pseudoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/x.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: KDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 2),
                  Text(
                    "Permis de conduire: Préparez-vous au succès",
                    style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
                  ),
                  Spacer(),
                  Text(
                    "Testez et renforcez vos connaissances pour réussir votre examen de conduite.",
                    style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text("Entrez vos informations d'abord :", style: TextStyle(color: Colors.white),),
                  SizedBox(height: 10,),
                  TextField(
                    controller: _pseudoController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: "Pseudo",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      if (_pseudoController.text.isNotEmpty) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Quizz(pseudo: _pseudoController.text)));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Erreur'),
                              content: Text('Veuillez entrer votre pseudo avant de démarrer le jeu.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(KDefaultPadding * 0.75),
                      decoration: BoxDecoration(gradient: KPrimaryGradient, borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Text("Commencer le quiz", style: Theme.of(context).textTheme.button?.copyWith(color: Colors.black)),
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
