import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/progress_bar_controller.dart';
import '../components/quiz_card.dart';

class Quizz extends StatefulWidget {
  final String pseudo;
  const Quizz({Key? key, required this.pseudo}) : super(key: key);

  @override
  State<Quizz> createState() => _QuizState();
}

class _QuizState extends State<Quizz> {
  final TextEditingController _pseudoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ProgressController _controller = Get.put(ProgressController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: QuizCard(pseudo: widget.pseudo,),
    );
  }
}
