import 'package:crm_game_joy/ui/screens/activity/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _counter = 0;

  void _incrementCounter() {
    // setState(() {
    //   _counter++;
    // });
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ActivityScreen(
          title: 'Название',
          description: 'Описание',
        ),
      ),
    );
  }

  var items = List<String>.generate(10000, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        children: [
          const _CalendarWidget(),
          _ActivityListWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Новая активность',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _ActivityListWidget extends StatelessWidget {
  _ActivityListWidget({Key? key}) : super(key: key);

  var items = List<String>.generate(10, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      prototypeItem: ListTile(
        title: Text(items.first),
      ),
      itemBuilder: (context, index) {
        return const ListTile(
          title: _ActivityCard(),
        );
      },
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text("ПОХОД"),
              // Text("Поход в пещерный город"),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalendarWidget extends StatefulWidget {
  const _CalendarWidget({Key? key}) : super(key: key);

  @override
  State<_CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<_CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Card(
        color: Colors.green,
        child: TableCalendar(
          headerStyle: const HeaderStyle(
            titleCentered: true,
            titleTextStyle: TextStyle(color: Colors.white),
            formatButtonTextStyle:
                TextStyle(fontSize: 14.0, color: Colors.white),
            formatButtonDecoration: BoxDecoration(
              border: Border.fromBorderSide(BorderSide(color: Colors.white)),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
          ),
          calendarStyle: const CalendarStyle(
            holidayTextStyle: TextStyle(color: Colors.white),
            weekendTextStyle: TextStyle(color: Colors.white),
            defaultTextStyle: TextStyle(color: Colors.white),
            rangeEndTextStyle: TextStyle(color: Colors.white),
            withinRangeTextStyle: TextStyle(color: Colors.white),
            outsideTextStyle: TextStyle(color: Colors.white),
            weekNumberTextStyle: TextStyle(color: Colors.white),
            //outsideTextStyle:TextStyle(color: Colors.white),
            //rangeHighlightColor:  Colors.white
          ),
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            // If this returns true, then `day` will be marked as selected.

            // Using `isSameDay` is recommended to disregard
            // the time-part of compared DateTime objects.
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              // Call `setState()` when updating the selected day
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              // Call `setState()` when updating calendar format
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            _focusedDay = focusedDay;
          },
        ),
      ),
    );
  }
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
