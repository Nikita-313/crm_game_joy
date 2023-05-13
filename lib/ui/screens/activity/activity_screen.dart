import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ActivityScreen extends StatelessWidget {
  final String title;
  final String description;
  const ActivityScreen({
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
                              hintText: 'Название',
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
                const SizedBox(height: 30),
                TransferPriceInputField(),
                const SizedBox(height: 30),
                PersonPriceInputField(),
                const SizedBox(height: 12),
                FormatPicker(),
                const Spacer(),
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
                  'Дата',
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
                  'Время',
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

class TransferPriceInputField extends StatefulWidget {
  const TransferPriceInputField({super.key});

  @override
  State<TransferPriceInputField> createState() =>
      _TransferPriceInputFieldState();
}

class _TransferPriceInputFieldState extends State<TransferPriceInputField> {
  String? price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Стоимость трансфера: '),
        const SizedBox(width: 8),
        Expanded(
            child: TextFormField(
          keyboardType: TextInputType.number,
        ))
      ],
    );
  }
}

class PersonPriceInputField extends StatefulWidget {
  const PersonPriceInputField({super.key});

  @override
  State<PersonPriceInputField> createState() => _PersonPriceInputFieldState();
}

class _PersonPriceInputFieldState extends State<PersonPriceInputField> {
  String? price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Цена за человека: '),
        const SizedBox(width: 8),
        Expanded(
            child: TextFormField(
          keyboardType: TextInputType.number,
        ))
      ],
    );
  }
}

class FormatPicker extends StatefulWidget {
  const FormatPicker({super.key});

  @override
  State<FormatPicker> createState() => _FormatPickerState();
}

class _FormatPickerState extends State<FormatPicker> {
  bool offlineChosen = false;
  bool onlineChosen = false;
  final List<String> offices = [
    'Все',
    'Севастополь',
    'Симферополь',
    'Феодосия',
  ];
  late String chosenValue = offices.first;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('Формат: '),
        ),
        Column(
          children: [
            LabeledCheckbox(
              label: "Офлайн",
              value: offlineChosen,
              onChanged: (val) {
                setState(() {
                  offlineChosen = true;
                  onlineChosen = false;
                });
              },
            ),
            LabeledCheckbox(
              label: "Онлайн",
              value: onlineChosen,
              onChanged: (val) {
                setState(() {
                  offlineChosen = false;
                  onlineChosen = true;
                });
              },
            ),
          ],
        ),
        const Spacer(),
        DropdownButton<String>(
          items: offices.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          value: chosenValue,
          onChanged: (val) {
            if (val != null) {
              setState(() {
                chosenValue = val;
              });
            }
          },
        )
      ],
    );
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: <Widget>[
          Checkbox(
            value: value,
            onChanged: (bool? newValue) {
              onChanged(newValue);
            },
          ),
          Text(label),
        ],
      ),
    );
  }
}
