import 'package:app/application/bloc/feedback/feedback_bloc.dart';
import 'package:app/presentation/utils/snack_bar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackDialog extends StatefulWidget {
  final String userEmail;

  const FeedbackDialog({super.key, required this.userEmail});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  bool isChecked = false;
  TextEditingController controller = TextEditingController();

  _FeedbackDialogState();

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<FeedbackBloc, FeedbackState>(
        builder: (BuildContext context, FeedbackState state) => SimpleDialog(
          title: const Text('Vaše zpětná vazba'),
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                  'Napište své nápady, připomínky nebo problémy, na které jste narazili.'),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: controller,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Text',
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (final bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    const Text('Přeji si být kontaktován')
                  ]),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pop();
                        },
                        child: const Text('Zavřít'),
                      ),
                      if (state is FeedbackSentInProgress)
                        const CircularProgressIndicator(),
                      if (state is FeedbackInitial)
                        TextButton(
                          onPressed: () {
                            final text = controller.text.toString();
                            final noWhitespacesText = text.replaceAll(' ', '');
                            if (noWhitespacesText.length < 10) {
                              SnackBarUtils.show(
                                context,
                                'Zpráva musí mít alespoň 10 znaků.',
                                Colors.red,
                              );
                            } else {
                              context.read<FeedbackBloc>().add(
                                    SendFeedback(
                                      email: isChecked ? widget.userEmail : '',
                                      type: isChecked ? 1 : 0,
                                      message: controller.text,
                                    ),
                                  );
                            }
                          },
                          child: const Text('Odeslat'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
