import 'package:care4plant/models/stress_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestionTest extends StatefulWidget {
  final String question;
  final Function(int, int) changeAnswer;
  final Stresstest stresstest;
  final int indexQuestion;
  const QuestionTest(
      {Key? key,
      required this.question,
      required this.changeAnswer,
      required this.stresstest,
      required this.indexQuestion})
      : super(key: key);

  @override
  QuestionTestState createState() => QuestionTestState();
}

TextStyle styleAnswer = const TextStyle(
    fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromRGBO(52, 67, 45, 1));
TextStyle styleAnswerSelected =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);

class QuestionTestState extends State<QuestionTest> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .8,
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(130, 159, 136, 1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(70), bottomRight: Radius.circular(70))),
              child: Column(children: [
                // Container(
                //   alignment: Alignment.centerLeft,
                //   margin: const EdgeInsets.only(bottom: 10),
                //   child: InkWell(
                //     onTap: () {},
                //     child: Icon(
                //       Icons.volume_up_outlined,
                //       size: MediaQuery.of(context).size.width * .1,
                //     ),
                //   ),
                // ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    widget.question,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        fontFamily: "Monserrat"),
                  ),
                )
              ]),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .02),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * .8,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(152, 194, 134, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(60, 120),
                            bottomLeft: Radius.elliptical(60, 120))),
                    child: Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * .2),
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.changeAnswer(widget.indexQuestion, 0);
                            });
                          },
                          child: Row(
                            children: [
                              Icon(Icons.sentiment_very_satisfied_outlined,
                                  size: 40,
                                  color: (widget.stresstest.getAnswer(widget.indexQuestion) == 0)
                                      ? Colors.white
                                      : Colors.black),
                              Text(AppLocalizations.of(context)!.answerOption1,
                                  style: (widget.stresstest.getAnswer(widget.indexQuestion) == 0)
                                      ? styleAnswerSelected
                                      : styleAnswer)
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.changeAnswer(widget.indexQuestion, 1);
                            });
                          },
                          child: Row(
                            children: [
                              Icon(Icons.sentiment_satisfied_alt_outlined,
                                  size: 40,
                                  color: (widget.stresstest.getAnswer(widget.indexQuestion) == 1)
                                      ? Colors.white
                                      : Colors.black),
                              Text(AppLocalizations.of(context)!.answerOption2,
                                  style: (widget.stresstest.getAnswer(widget.indexQuestion) == 1)
                                      ? styleAnswerSelected
                                      : styleAnswer)
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.changeAnswer(widget.indexQuestion, 2);
                            });
                          },
                          child: Row(
                            children: [
                              Icon(Icons.sentiment_neutral_outlined,
                                  size: 40,
                                  color: (widget.stresstest.getAnswer(widget.indexQuestion) == 2)
                                      ? Colors.white
                                      : Colors.black),
                              Text(AppLocalizations.of(context)!.answerOption3,
                                  style: (widget.stresstest.getAnswer(widget.indexQuestion) == 2)
                                      ? styleAnswerSelected
                                      : styleAnswer)
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.changeAnswer(widget.indexQuestion, 3);
                            });
                          },
                          child: Row(
                            children: [
                              Icon(Icons.sentiment_dissatisfied,
                                  size: 40,
                                  color: (widget.stresstest.getAnswer(widget.indexQuestion) == 3)
                                      ? Colors.white
                                      : Colors.black),
                              Flexible(
                                  child: Text(AppLocalizations.of(context)!.answerOption4,
                                      style:
                                          (widget.stresstest.getAnswer(widget.indexQuestion) == 3)
                                              ? styleAnswerSelected
                                              : styleAnswer))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.changeAnswer(widget.indexQuestion, 4);
                            });
                          },
                          child: Row(
                            children: [
                              Icon(Icons.sentiment_dissatisfied_outlined,
                                  size: 40,
                                  color: (widget.stresstest.getAnswer(widget.indexQuestion) == 4)
                                      ? Colors.white
                                      : Colors.black),
                              Flexible(
                                  child: Text(
                                AppLocalizations.of(context)!.answerOption5,
                                style: (widget.stresstest.getAnswer(widget.indexQuestion) == 4)
                                    ? styleAnswerSelected
                                    : styleAnswer,
                              ))
                            ],
                          ),
                        )
                      ]),
                    ))
              ],
            )
          ],
        )
      ],
    );
  }
}
