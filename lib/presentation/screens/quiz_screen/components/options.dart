import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview/constants/constants.dart';
import 'package:flutter_interview/logic/cubit/quiz_cubit.dart';

class Options extends StatelessWidget {
  final String text;
  final int index;
  final VoidCallback press;
  const Options({
    Key? key,
    required this.text,
    required this.index,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = QuizCubit.get(context);
        Color getTheRightColor() {
          if (cubit.isAnswered) {
            if (index == cubit.correctAnswer) {
              return MyColors.kGreenColor;
            } else if (index == cubit.selectedAnswer &&
                cubit.selectedAnswer != cubit.correctAnswer) {
              return MyColors.kRedColor;
            }
          }
          return MyColors.kGreyColor;
        }

        IconData getTheRightIcon() {
          return getTheRightColor() == MyColors.kRedColor
              ? Icons.close
              : Icons.done;
        }

        return InkWell(
          onTap: press,
          child: Container(
            margin: EdgeInsets.only(top: kDefaultPadding),
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              border: Border.all(color: getTheRightColor()),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${index + 1}. $text",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: TextStyle(
                    color: getTheRightColor(),
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    color: getTheRightColor() == MyColors.kGreyColor
                        ? Colors.transparent
                        : getTheRightColor(),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: getTheRightColor(),
                    ),
                  ),
                  child: getTheRightColor() == MyColors.kGreyColor
                      ? null
                      : Icon(
                          getTheRightIcon(),
                          size: 16,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
