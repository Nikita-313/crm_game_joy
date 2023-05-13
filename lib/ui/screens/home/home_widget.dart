import 'package:crm_game_joy/domain/data/newtwork/api_activity.dart';
import 'package:crm_game_joy/domain/sevice/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../domain/model/activity.dart';

enum LoadStatus { loaded, loading, error }

class _ViewModel extends ChangeNotifier {
  final apiActivity = ApiActivity();
  final test = AuthService();
  LoadStatus loadStatus = LoadStatus.loading;
  DateTime dateTimeSelected= DateTime.now();

  _ViewModel() {
    getActivities();
  }

  List<Activity> list = [];

  void getActivities() async {
    loadStatus = LoadStatus.loading;
    notifyListeners();
    var startSting = DateFormat('yyyy-MM-dd').format(dateTimeSelected);
    var endSting = DateFormat('yyyy-MM-dd').format(dateTimeSelected);
    //await test.auth("ivan.zakharyan@joy-dev.ru");
    try {
      list = await apiActivity.getActivities(startSting, endSting) ?? [];
    } catch (e) {
      loadStatus = LoadStatus.error;
      notifyListeners();
      return;
    }
    loadStatus = LoadStatus.loaded;
    notifyListeners();
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<_ViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                _PlaningWidget(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: _CalendarWidget(),
                ),
                SizedBox(
                  height: 20,
                ),
                _ActivityListWidget(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          vm.getActivities();
        },
        tooltip: 'Новая активность',
        child: const Icon(Icons.add),
      ),
    );
  }

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => _ViewModel(),
      child: const HomeWidget(),
    );
  }
}

class _ActivityListWidget extends StatelessWidget {
  const _ActivityListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<_ViewModel>();
    return Column(
      children: [
        if (vm.loadStatus == LoadStatus.loaded)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                vm.list.isEmpty ? "Нет активностей" : "Активности",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              for (int i = 0; i < vm.list.length; i++)
                _ActivityCard(
                  activity: vm.list[i],
                )
            ],
          ),
        if (vm.loadStatus == LoadStatus.loading) const _ProgressIndicator(),
        if (vm.loadStatus == LoadStatus.error) const _RefreshButton(),
      ],
    );
  }
}

class _RefreshButton extends StatelessWidget {
  const _RefreshButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.read<_ViewModel>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Ошибка загрузки"),
        const SizedBox(
          height: 10,
        ),
        IconButton(
            onPressed: () {
              vm.getActivities();
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.black.withOpacity(0.4),
            )),
      ],
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

class _ActivityCard extends StatelessWidget {
  _ActivityCard({Key? key, required this.activity}) : super(key: key);

  Activity activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      child: Stack(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(child: Icon(Icons.pedal_bike)),
          ),
          Container(
            margin: const EdgeInsets.only(left: 53),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  activity.name ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  activity.cities
                          ?.reduce((value, element) => '$value,$element') ??
                      "",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.4)),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.messenger_outline_rounded,
                          color: Colors.black.withOpacity(0.3),
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 200),
                          child: Text(
                            activity.description ?? "",
                            style: const TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
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
    final vm = context.read<_ViewModel>();
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      child: Card(
        color: Colors.white,
        child: TableCalendar(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              vm.dateTimeSelected = selectedDay;
              vm.getActivities();
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
      ),
    );
  }
}

class _PlaningWidget extends StatelessWidget {
  const _PlaningWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.4)),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(10.0),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.pin_drop_outlined),
                SizedBox(
                  width: 5,
                ),
                Text("Planning on",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "May, 27",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFFF86161),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  children: const [
                    Text("Кинотеатр"),
                    SizedBox(
                      width: 10,
                    ),
                    Text("65%")
                  ],
                ),
                Row(
                  children: const [
                    Text("Ночевка в горах"),
                    SizedBox(
                      width: 10,
                    ),
                    Text("35%")
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: Row(
                children: [
                  Expanded(
                      flex: 65,
                      child: Container(
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF86161),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 35,
                      child: Container(
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3A3A3A),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year - 1, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year + 1, kToday.month, kToday.day);
