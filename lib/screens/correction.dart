import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../components/colors.dart';
import '../controllers/progress_bar_controller.dart';

class Correct extends StatefulWidget {
  const Correct({super.key});

  @override
  State<Correct> createState() => _CorrectState();
}

class _CorrectState extends State<Correct> {
  List _items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString("lib/assets/bddjson/quiz.json");
    final data = json.decode(response);
    if (mounted) {
      setState(() {
        _items = data["items"];
      });
      Get.find<ProgressControllers>().initializeQuestions(_items.length);
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Eléments de réponse"),
        backgroundColor: Colors.blueGrey,
      ),
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
          _items.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: KGrayColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          _items[index]["chemin"],
                          height: 100,
                        ),
                        SizedBox(height: 20),
                        Text(
                          _items[index]["question"],
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: KSecondaryColor),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Obx(() {
                      var questionState = _controller.questionsState[index];

                      return Column(
                        children: _items[index]["options"]
                            .asMap()
                            .entries
                            .map<Widget>((entry) {
                          int optionIndex = entry.key;
                          var option = entry.value;
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              padding: EdgeInsets.all(KDefaultPadding),
                              decoration: BoxDecoration(
                                border: Border.all(color: KGrayColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    option["text"],
                                    style: TextStyle(color: KGrayColor, fontSize: 16),
                                  ),
                                  Container(
                                    height: 26,
                                    width: 26,
                                    decoration: BoxDecoration(
                                      color: KGrayColor,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(color: KGrayColor),
                                    ),
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
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
        ],
      ),
    );
  }
}
class ProgressControllers extends GetxController {
  var questionsState = <QuestionState>[].obs;


  void initializeQuestions(int length) {
    questionsState.value = List.generate(length, (index) => QuestionState());
  }
}

class QuestionState {

}