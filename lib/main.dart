import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Календарь',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.orange,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ),
      home: const CalendarApp(),
    );
  }
}

class CalendarApp extends StatefulWidget {
  const CalendarApp({super.key});

  @override
  State<CalendarApp> createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {
  DateTime _selectedDate = DateTime.now();
  DateTime _currentDate = DateTime.now();

  void _previousMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 1);
    });
  }

  void _previousYear() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year - 1, _selectedDate.month, 1);
    });
  }

  void _nextYear() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year + 1, _selectedDate.month, 1);
    });
  }

  void _goToCurrentMonth() {
    setState(() {
      _selectedDate = _currentDate;
    });
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Январь';
      case 2:
        return 'Февраль';
      case 3:
        return 'Март';
      case 4:
        return 'Апрель';
      case 5:
        return 'Май';
      case 6:
        return 'Июнь';
      case 7:
        return 'Июль';
      case 8:
        return 'Август';
      case 9:
        return 'Сентябрь';
      case 10:
        return 'Октябрь';
      case 11:
        return 'Ноябрь';
      case 12:
        return 'Декабрь';
      default:
        return '';
    }
  }

  
  int _getDaysInMonth(int year, int month) {
    if (month == 2) {
      return ((year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) ? 29 : 28);
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
      return 30;
    } else {
      return 31;
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final firstDayOfWeek = firstDayOfMonth.weekday;
    final daysInMonth = _getDaysInMonth(_selectedDate.year, _selectedDate.month);

    
    List<List<int?>> calendarDays = [];
    int currentDay = 1;
    int weekDay = firstDayOfWeek - 1; 

    
    for (int i = 0; i < 6; i++) {
      calendarDays.add([]);
      for (int j = 0; j < 7; j++) {
        if (i == 0 && j < weekDay) {
          calendarDays[i].add(null);
        } else {
          if (currentDay <= daysInMonth) {
            calendarDays[i].add(currentDay);
            currentDay++;
          } else {
            calendarDays[i].add(null);
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
        ),
        actions: [
          IconButton(
            onPressed: _previousYear,
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.orange,
          ),
          IconButton(
            onPressed: _nextYear,
            icon: const Icon(Icons.arrow_forward_ios),
            color: Colors.orange,
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _previousMonth,
                child: const Icon(Icons.arrow_back_ios),
              ),
              ElevatedButton(
                onPressed: _goToCurrentMonth,
                child: const Text('Сегодня'),
              ),
              ElevatedButton(
                onPressed: _nextMonth,
                child: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.2,
            ),
            itemCount: 7,
            itemBuilder: (context, index) {
              return Center(
                child: Text(
                  _getDayOfWeekName(index + 1),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              );
            },
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.2,
            ),
            itemCount: 42, 
            itemBuilder: (context, index) {
              final day = calendarDays[index ~/ 7][index % 7];
              if (day == null) {
                return Container(); 
              } else {
                return Center(
                  child: Text(
                    '$day',
                    style: TextStyle(
                      color: _selectedDate.day == day
                          ? Colors.orange
                          : Colors.white,
                      fontSize: 18,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
  String _getDayOfWeekName(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Пн';
      case 2:
        return 'Вт';
      case 3:
        return 'Ср';
      case 4:
        return 'Чт';
      case 5:
        return 'Пт';
      case 6:
        return 'Сб';
      case 7:
        return 'Вс';
      default:
        return '';
    }
  }
}