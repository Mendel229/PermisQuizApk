import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/score.dart'; // Importez l'écran de score

class ProgressController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  Animation<double> get animation => this._animation;

  late PageController _pageController;
  PageController get pageController => this._pageController;

  List<RxMap<String, dynamic>> _questionsState = [];
  List<RxMap<String, dynamic>> get questionsState => this._questionsState;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numberOfCorrectAns = 0;
  int get numberOfCorrectAns => this._numberOfCorrectAns;

  bool get allQuestionsAnswered {
    for (var questionState in questionsState) {
      if (!questionState["isAnswered"]) {
        return false;
      }
    }
    return true;
  }

  String pseudo = "";

  void initializePseudo(String pseudo) {
    this.pseudo = pseudo;
  }

  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(duration: Duration(seconds: 30), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        update();
      });
    _animationController.forward();
    _pageController = PageController();
  }

  void resetController() {
    _questionNumber.value = 1;
    _numberOfCorrectAns = 0;
    _animationController.reset();
    _animationController.forward();
    for (var questionState in _questionsState) {
      questionState["isAnswered"] = false;
      questionState["correctAns"] = -1;
      questionState["selectedAns"] = -1;
    }
    _pageController.jumpToPage(0);
    update();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void initializeQuestionsState(int totalQuestions) {
    _questionsState = List.generate(
      totalQuestions,
          (_) => {
        "isAnswered": false,
        "correctAns": -1,
        "selectedAns": -1,
      }.obs,
    );
  }

  void checkAns(int questionIndex, Map question, int selectedIndex) {
    var questionState = _questionsState[questionIndex];
    questionState["isAnswered"] = true;
    questionState["correctAns"] = question["answers_index"] - 1;
    questionState["selectedAns"] = selectedIndex;

    if (questionState["correctAns"] == questionState["selectedAns"]) {
      _numberOfCorrectAns++;
    }

    _animationController.stop();
    update();

    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value < _questionsState.length) {
      _questionNumber.value++;
      _pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.ease);
      _animationController.reset();
      _animationController.forward().whenComplete(nextQuestion);
    } else {

    }
  }



  int calculateScore() {
    if (_questionsState.isEmpty) {
      return 0; // Évite la division par zéro
    }
    double score = (_numberOfCorrectAns / _questionsState.length) * 100;
    if (score.isInfinite || score.isNaN) {
      return 0;
    }
    return score.toInt();
  }
}
