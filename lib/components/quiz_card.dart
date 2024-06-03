import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quiz/components/progresbar.dart';
import '../components/colors.dart';
import '../controllers/progress_bar_controller.dart';
import '../screens/score.dart';

class QuizCard extends StatefulWidget {
  final String pseudo;
  const QuizCard({Key? key, required this.pseudo}) : super(key: key);

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  List _items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString("lib/assets/bddjson/quiz.json");
    final data = await json.decode(response);
    if (mounted) {
      setState(() {
        _items = data["items"];
        if (_items.isNotEmpty) {
          Get.find<ProgressController>().initializeQuestionsState(_items.length);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    ProgressController _controller = Get.put(ProgressController());
    _controller.initializePseudo(widget.pseudo);

    return Stack(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: KDefaultPadding),
                child: Progressbar(),
              ),
              SizedBox(height: KDefaultPadding,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: KDefaultPadding),
                child: Obx(() => Text.rich(
                  TextSpan(
                    text: "Question ${_controller.questionNumber.value}",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: KSecondaryColor),
                    children: [
                      TextSpan(
                        text: "/${_items.length}",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: KSecondaryColor),
                      )
                    ],
                  ),
                )),
              ),
              Divider(thickness: 1.5,),
              SizedBox(height: KDefaultPadding,),
              Expanded(
                child: _items.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _controller.pageController,
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: KDefaultPadding),
                      padding: EdgeInsets.all(KDefaultPadding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Image(
                                image: AssetImage(_items[index]["chemin"]),
                                height: 100,
                              ),
                              Text(
                                _items[index]["question"],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(color: KSecondaryColor),
                              ),
                            ],
                          ),
                          SizedBox(height: KDefaultPadding / 100,),
                          Obx(() {
                            var questionState = _controller.questionsState[index];

                            Color getTheRightColor(int optionIndex) {
                              if (questionState["isAnswered"]) {
                                if (optionIndex == questionState["correctAns"]) {
                                  return KGreenColor;
                                } else if (optionIndex == questionState["selectedAns"] &&
                                    questionState["selectedAns"] != questionState["correctAns"]) {
                                  return KRedColor;
                                }
                              }
                              return KGrayColor;
                            }

                            IconData getTheRightIcon(int optionIndex) {
                              if (questionState["isAnswered"]) {
                                if (optionIndex == questionState["correctAns"]) {
                                  return Icons.done;
                                } else if (optionIndex == questionState["selectedAns"] &&
                                    questionState["selectedAns"] != questionState["correctAns"]) {
                                  return Icons.close;
                                }
                              }
                              return Icons.circle;
                            }

                            return Column(
                              children: _items[index]["options"]
                                  .asMap()
                                  .entries
                                  .map<Widget>((entry) {
                                int optionIndex = entry.key;
                                var option = entry.value;
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (!questionState["isAnswered"]) {
                                        _controller.checkAns(index, _items[index], optionIndex);
                                        if (Get.find<ProgressController>().allQuestionsAnswered) {
                                          Get.off(() => Score(pseudo: widget.pseudo));
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(KDefaultPadding),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: getTheRightColor(optionIndex)),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            option["text"],
                                            style: TextStyle(color: getTheRightColor(optionIndex), fontSize: 16),
                                          ),
                                          Container(
                                            height: 26,
                                            width: 26,
                                            decoration: BoxDecoration(
                                              color: getTheRightColor(optionIndex) == KGrayColor
                                                  ? Colors.transparent
                                                  : getTheRightColor(optionIndex),
                                              borderRadius: BorderRadius.circular(50),
                                              border: Border.all(color: getTheRightColor(optionIndex)),
                                            ),
                                            child: Icon(
                                              getTheRightIcon(optionIndex),
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ],
    );
  }
}
