import 'package:app/application/dto/member_dto.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';

class GroupComplete extends StatefulWidget {
  List<MemberDto> acceptedMember;

  GroupComplete({super.key, required this.acceptedMember});

  @override
  State<GroupComplete> createState() => _GroupCompleteState();
}

class _GroupCompleteState extends State<GroupComplete> {
  @override
  Widget build(final BuildContext context) {
    final atLeastOneCommander =
        widget.acceptedMember.any((final e) => e.memberFunctionType == 1);
    final atLeastOneTechnic =
        widget.acceptedMember.any((final e) => e.memberFunctionType == 2);
    final firefightersCount = widget.acceptedMember
        .where((final e) => e.memberFunctionType == 3)
        .length;

    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 3),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(
                width: 2,
                color: atLeastOneCommander ? JayColors.green : Colors.transparent,
              ),
            ),
            child: Text(
              "V",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: atLeastOneCommander ? JayColors.green : Colors.black38,
                  fontSize: 16),
            )),
        Container(
            margin: EdgeInsets.only(left: 3),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: atLeastOneTechnic ? JayColors.green :  Colors.transparent,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(
              "S",
              style: TextStyle(
                  fontSize: 16,
                  color: atLeastOneTechnic ? JayColors.green : Colors.black38,
                  fontWeight: FontWeight.w900),
            )),
        Container(
            margin: EdgeInsets.only(left: 3),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color:
                    firefightersCount >= 1 ? JayColors.green : Colors.transparent,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(
              "H",
              style: TextStyle(
                  fontSize: 16,
                  color:  firefightersCount >= 1  ? JayColors.green : Colors.black38,
                  fontWeight: FontWeight.bold),
            )),
        Container(
            margin: EdgeInsets.only(left: 3),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color:
                    firefightersCount >= 2 ? JayColors.green :  Colors.transparent,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(
              "H",
              style: TextStyle(
                  fontSize: 16,
                  color: firefightersCount >= 2  ? JayColors.green : Colors.black38,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
