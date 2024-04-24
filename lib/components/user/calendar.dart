import 'package:booqs_mobile/data/remote/users.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/daily_report.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/date_time_formatter.dart';
import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';

class UserCalendar extends StatefulWidget {
  const UserCalendar({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<UserCalendar> createState() => _UserCalendarState();
}

class _UserCalendarState extends State<UserCalendar> {
  final _cellCalendarPageController = CellCalendarPageController();
  final List<CalendarEvent> _eventsList = [];

  @override
  void initState() {
    final DateTime today = DateTime.now();
    final DateTime firstDate = DateTimeFormatter.firstDayOfMonth(today);
    final DateTime lastDate = DateTimeFormatter.lastDayOfMonth(today);
    _loadEvents(firstDate, lastDate);
    super.initState();
  }

  Future<void> _loadEvents(DateTime firstDate, DateTime lastDate) async {
    final Map? resMap = await RemoteUsers.loadCalendarEvents(
        widget.user.publicUid, firstDate, lastDate);
    if (resMap == null) return;
    _eventsList.clear();
    resMap['daily_reports'].forEach((e) {
      final DailyReport dailyReport = DailyReport.fromJson(e);
      final Color backgroundColor =
          dailyReport.goalAchievement ? Colors.redAccent : Colors.lightGreen;
      final event = CalendarEvent(
        eventName: t.calendars.answers(count: '${dailyReport.answersCount}'),
        eventTextStyle: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            height: 1.2,
            fontWeight: FontWeight.bold),
        eventDate: dailyReport.measuredDate,
        eventBackgroundColor: backgroundColor,
      );
      _eventsList.add(event);
      if (dailyReport.reviewCompletion) {
        _eventsList.add(CalendarEvent(
          eventName: t.calendars.reviewed,
          eventTextStyle: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              height: 1.2,
              fontWeight: FontWeight.bold),
          eventDate: dailyReport.measuredDate,
          eventBackgroundColor: Colors.blueAccent,
        ));
      }
    });
    if (!mounted) return;
    setState(() {
      _eventsList;
    });
  }

  @override
  void dispose() {
    _cellCalendarPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // column内ではexpandは利用できない。
    // sizedBoxでサイズを指定する。
    return SizedBox(
      height: 560,
      child: CellCalendar(
        cellCalendarPageController: _cellCalendarPageController,
        events: _eventsList,
        todayMarkColor: Colors.lightGreen,
        daysOfTheWeekBuilder: (dayIndex) {
          final labels = [
            t.calendars.sunday,
            t.calendars.monday,
            t.calendars.tuesday,
            t.calendars.wednesday,
            t.calendars.thursday,
            t.calendars.friday,
            t.calendars.saturday
          ];
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              labels[dayIndex],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
        monthYearLabelBuilder: (datetime) {
          final year = datetime?.year.toString();
          final month = datetime?.month.toString();
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  "$year / $month",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    _cellCalendarPageController.animateToDate(
                      DateTime.now(),
                      curve: Curves.linear,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                )
              ],
            ),
          );
        },
        onCellTapped: (date) {},
        onPageChanged: (firstDate, lastDate) async {
          await _loadEvents(firstDate, lastDate);

          /// Called when the page was changed
          /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
        },
      ),
    );
  }
}
