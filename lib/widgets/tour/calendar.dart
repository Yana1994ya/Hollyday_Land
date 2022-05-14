import "package:flutter/material.dart";
import "package:hollyday_land/api_server.dart";
import "package:table_calendar/table_calendar.dart";

class AvailableDate {
  final DateTime dateTime;

  AvailableDate(this.dateTime);
}

class TourCalendar extends StatefulWidget {
  final int tourId;
  final void Function(DateTime) onOrder;

  const TourCalendar({Key? key, required this.tourId, required this.onOrder})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TourCalendarState();
}

class _TourCalendarState extends State<TourCalendar> {
  bool loading = true;
  Set<int> days = {};
  DateTime? selectedDate;
  late DateTime focusedDate;

  @override
  void initState() {
    final currentDate = DateTime.now();
    focusedDate = currentDate;

    loadMonth(currentDate.month, currentDate.year);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(Duration(days: 70)),
          focusedDay: focusedDate,
          headerStyle: HeaderStyle(formatButtonVisible: false),
          onPageChanged: (pageDate) {
            loadMonth(pageDate.month, pageDate.year);
          },
          onDaySelected: (selectedDate, _focusedDate) {
            if (!days.contains(selectedDate.day)) {
              setState(() {
                this.selectedDate = null;
              });

              return;
            }

            setState(() {
              this.selectedDate = selectedDate;
            });
          },
          calendarBuilders:
              CalendarBuilders(defaultBuilder: (context, day, focused) {
            if (!loading && days.contains(day.day)) {
              if (selectedDate != null && selectedDate!.day == day.day) {
                return Center(
                  child: Text(
                    day.day.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    day.day.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                    ),
                  ),
                );
              }
            }

            return Center(child: Text(day.day.toString()));
          }),
        ),
        ElevatedButton(
            onPressed: selectedDate == null
                ? null
                : () {
                    widget.onOrder(selectedDate!);
                  },
            child: Text("Order"))
      ],
    );
  }

  void loadMonth(int month, int year) {
    // When loading, start from an empty page
    setState(() {
      loading = true;
      days.clear();
      final DateTime current = DateTime.now();

      if (current.month == month && current.year == year) {
        focusedDate = current;
      } else {
        focusedDate = DateTime(year, month, 1);
      }
    });

    ApiServer.get(
            "attractions/api/tours/availability/${widget.tourId}/$year/$month",
            "days")
        .then((value) {
      final List<dynamic> loadedDays = value;

      setState(() {
        days = loadedDays.map((v) => v as int).toSet();
        loading = false;
      });
    });
  }
}
