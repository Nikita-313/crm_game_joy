import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class VotingScreen extends StatelessWidget {
  final String title;
  final String description;
  const VotingScreen({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Title',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: const Color(0xFF1D1B20).withOpacity(0.5),
                              ),
                            ),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
                const SizedBox(height: 30),
                DateInputField(),
                const SizedBox(height: 30),
                TimePicker(),
                const SizedBox(height: 15),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Description',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: const Color(0xFF1D1B20).withOpacity(0.5),
                              ),
                            ),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                    bottom: 20,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Добавить'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Divider extends StatelessWidget {
  const Divider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: const Color(0xFF1D1B20).withOpacity(0.5),
    );
  }
}

class DateInputField extends StatefulWidget {
  const DateInputField({super.key});

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        ).then((value) {
          if (value != null) {
            setState(() {
              pickedDate = value;
            });
          }
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color(0xFF1D1B20).withOpacity(0.5),
                  ),
                ),
                const Spacer(),
                Text((pickedDate ?? '').toString()),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? pickedStartTime;
  TimeOfDay? pickedEndTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(
            DateTime.now(),
          ),
        ).then((value) {
          if (value != null) {
            setState(() {
              pickedStartTime = value;
            });
            showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(
                DateTime.now(),
              ),
            ).then((value) {
              if (value != null) {
                setState(() {
                  pickedEndTime = value;
                });
              }
            });
          }
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Time',
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color(0xFF1D1B20).withOpacity(0.5),
                  ),
                ),
                const Spacer(),
                Text(
                  pickedStartTime != null
                      ? '${pickedStartTime!.hour}:${pickedStartTime!.minute}'
                      : '',
                ),
                if (pickedStartTime != null) ...[
                  const SizedBox(width: 4),
                  const Icon(
                    CupertinoIcons.arrow_right,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  pickedEndTime != null
                      ? '${pickedEndTime!.hour}:${pickedEndTime!.minute}'
                      : '',
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
