import 'dart:async';
import 'dart:math';

import 'package:calendar_view/calendar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:multifocus/screens/components/music_player_component.dart';
import 'package:multifocus/widgets/text_widget.dart';
import 'package:multifocus/widgets/toast_widget.dart';

import '../utils/colors.dart';
import '../utils/routes.dart';

bool isMusicPlaying = false;

final box = GetStorage();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool calendarClicked = true;
  bool todolistClicked = false;
  bool timerClicked = false;
  bool musicClicked = false;
  bool notesClicked = false;

  bool settingsClicked = false;
  final urlController = TextEditingController();

  bool isExpanded = true;

  List backgroundImages = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
    'assets/images/6.jpg',
    'assets/images/7.jpg',
  ];

  String backgroundImage = 'assets/images/1.jpg';

  final todoController = TextEditingController();
  List todos = [];

  bool isPlaying = false;
  bool isPomodoro = true;
  bool isShortBreak = false;
  bool isLongBreak = false;
  int durationMinutes = 30; // Default duration for Pomodoro (30 minutes)
  Timer? countdownTimer;
  int countdownValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                backgroundImage,
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 50),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 45,
                  width: isExpanded ? 620 : 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Image.asset(
                            'assets/images/MultiFocus_Black@4x.png',
                          ),
                        ),
                      ),
                      isExpanded
                          ? TextButton(
                              onPressed: () {
                                setState(() {
                                  calendarClicked = !calendarClicked;
                                });
                              },
                              child: Text(
                                'Calendar',
                                style: TextStyle(
                                  decoration: calendarClicked
                                      ? TextDecoration.underline
                                      : null,
                                  fontSize: 14,
                                  color: calendarClicked
                                      ? Colors.black
                                      : Colors.grey,
                                  fontFamily: 'QRegular',
                                ),
                              ))
                          : const SizedBox(),
                      isExpanded
                          ? const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: VerticalDivider(),
                            )
                          : const SizedBox(),
                      isExpanded
                          ? TextButton(
                              onPressed: () {
                                setState(() {
                                  todolistClicked = !todolistClicked;
                                });
                              },
                              child: Text(
                                'To-Do List',
                                style: TextStyle(
                                  decoration: todolistClicked
                                      ? TextDecoration.underline
                                      : null,
                                  fontSize: 14,
                                  color: todolistClicked
                                      ? Colors.black
                                      : Colors.grey,
                                  fontFamily: 'QRegular',
                                ),
                              ))
                          : const SizedBox(),
                      isExpanded
                          ? const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: VerticalDivider(),
                            )
                          : const SizedBox(),
                      isExpanded
                          ? TextButton(
                              onPressed: () {
                                setState(() {
                                  timerClicked = !timerClicked;
                                });
                              },
                              child: Text(
                                'Pomodoro Timer',
                                style: TextStyle(
                                  decoration: timerClicked
                                      ? TextDecoration.underline
                                      : null,
                                  fontSize: 14,
                                  color:
                                      timerClicked ? Colors.black : Colors.grey,
                                  fontFamily: 'QRegular',
                                ),
                              ))
                          : const SizedBox(),
                      isExpanded
                          ? const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: VerticalDivider(),
                            )
                          : const SizedBox(),
                      isExpanded
                          ? TextButton(
                              onPressed: () {
                                setState(() {
                                  notesClicked = !notesClicked;
                                });
                              },
                              child: Text(
                                'Sticky Notes',
                                style: TextStyle(
                                  decoration: notesClicked
                                      ? TextDecoration.underline
                                      : null,
                                  fontSize: 14,
                                  color:
                                      notesClicked ? Colors.black : Colors.grey,
                                  fontFamily: 'QRegular',
                                ),
                              ),
                            )
                          : const SizedBox(),
                      isExpanded
                          ? const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: VerticalDivider(),
                            )
                          : const SizedBox(),
                      isExpanded
                          ? TextButton(
                              onPressed: () {
                                setState(() {
                                  musicClicked = !musicClicked;
                                });
                              },
                              child: Text(
                                'Music',
                                style: TextStyle(
                                  decoration: musicClicked
                                      ? TextDecoration.underline
                                      : null,
                                  fontSize: 14,
                                  color:
                                      musicClicked ? Colors.black : Colors.grey,
                                  fontFamily: 'QRegular',
                                ),
                              ))
                          : const SizedBox(),
                      isExpanded
                          ? const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: VerticalDivider(),
                            )
                          : const SizedBox(),
                      isExpanded
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  settingsClicked = !settingsClicked;
                                });
                              },
                              icon: Icon(
                                Icons.settings,
                                color: settingsClicked
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  calendarClicked
                      ? Container(
                          height: 500,
                          width: 400,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            calendarClicked = !calendarClicked;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.remove,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: TextBold(
                                      text: 'Your Calendar:',
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 415,
                                    width: min(
                                        MediaQuery.of(context).size.width * 0.8,
                                        1024),
                                    child: WeekView(
                                      eventTileBuilder:
                                          (date, events, boundry, start, end) {
                                        // Return your widget to display as event tile.
                                        return Padding(
                                          padding: const EdgeInsets.all(2.5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blue[400],
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.5),
                                              child: TextRegular(
                                                  text: events[0].title,
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        );
                                      },
                                      initialDay: DateTime.now(),
                                      headerStyle: const HeaderStyle(
                                          headerTextStyle: TextStyle(
                                            fontFamily: 'QRegular',
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          )),
                                      width: 375,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, bottom: 10),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: FloatingActionButton(
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                            return AlertDialog(
                                              title: TextRegular(
                                                  text: 'Input Event Details',
                                                  fontSize: 16,
                                                  color: Colors.black),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextField(
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: 'Title',
                                                      labelStyle: TextStyle(
                                                        fontFamily: 'Regular',
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        title = value;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      TextRegular(
                                                          text: 'Start Time:',
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                      const SizedBox(width: 10),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          TimeOfDay?
                                                              pickedTime =
                                                              await showTimePicker(
                                                            builder: (context,
                                                                child) {
                                                              return Theme(
                                                                data: Theme.of(
                                                                        context)
                                                                    .copyWith(
                                                                  colorScheme:
                                                                      const ColorScheme
                                                                          .light(
                                                                    primary:
                                                                        primary,
                                                                    onPrimary:
                                                                        Colors
                                                                            .white,
                                                                    onSurface:
                                                                        Colors
                                                                            .grey,
                                                                  ),
                                                                ),
                                                                child: child!,
                                                              );
                                                            },
                                                            initialTime:
                                                                TimeOfDay.now(),
                                                            context: context,
                                                          );

                                                          if (pickedTime !=
                                                              null) {
                                                            setState(() {
                                                              startTime =
                                                                  pickedTime;
                                                              pickedstartTime =
                                                                  true;
                                                            });
                                                          } else {
                                                            return;
                                                          }
                                                        },
                                                        child: TextRegular(
                                                          text: pickedstartTime
                                                              ? '${startTime.hour}:${startTime.minute} '
                                                              : 'Select Start Time',
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      TextRegular(
                                                          text: 'End Time:',
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                      const SizedBox(width: 10),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          TimeOfDay?
                                                              pickedTime =
                                                              await showTimePicker(
                                                            builder: (context,
                                                                child) {
                                                              return Theme(
                                                                data: Theme.of(
                                                                        context)
                                                                    .copyWith(
                                                                  colorScheme:
                                                                      const ColorScheme
                                                                          .light(
                                                                    primary:
                                                                        primary,
                                                                    onPrimary:
                                                                        Colors
                                                                            .white,
                                                                    onSurface:
                                                                        Colors
                                                                            .grey,
                                                                  ),
                                                                ),
                                                                child: child!,
                                                              );
                                                            },
                                                            initialTime:
                                                                TimeOfDay.now(),
                                                            context: context,
                                                          );

                                                          if (pickedTime !=
                                                              null) {
                                                            setState(() {
                                                              endTime =
                                                                  pickedTime;
                                                              pickedendTime =
                                                                  true;
                                                            });
                                                          } else {
                                                            return;
                                                          }
                                                        },
                                                        child: TextRegular(
                                                          text: pickedendTime
                                                              ? '${endTime.hour}:${endTime.minute} '
                                                              : 'Select End Time',
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      TextRegular(
                                                          text: 'Date:',
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                      const SizedBox(width: 10),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          DateTime? pickedDate =
                                                              await showDatePicker(
                                                                  builder:
                                                                      (context,
                                                                          child) {
                                                                    return Theme(
                                                                      data: Theme.of(
                                                                              context)
                                                                          .copyWith(
                                                                        colorScheme:
                                                                            const ColorScheme.light(
                                                                          primary:
                                                                              primary,
                                                                          onPrimary:
                                                                              Colors.white,
                                                                          onSurface:
                                                                              Colors.grey,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          child!,
                                                                    );
                                                                  },
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      DateTime
                                                                          .now(),
                                                                  firstDate:
                                                                      DateTime(
                                                                          2023),
                                                                  lastDate:
                                                                      DateTime(
                                                                          2050));

                                                          if (pickedDate !=
                                                              null) {
                                                            setState(() {
                                                              date = pickedDate;
                                                              pickeddate = true;
                                                            });
                                                          } else {
                                                            return;
                                                          }
                                                        },
                                                        child: TextRegular(
                                                          text: pickeddate
                                                              ? DateFormat(
                                                                      'yyyy-MM-dd')
                                                                  .format(date)
                                                              : 'Select Date',
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        CalendarControllerProvider
                                                                .of(context)
                                                            .controller
                                                            .add(
                                                                CalendarEventData(
                                                              startTime: DateTime(
                                                                  DateTime.now()
                                                                      .year,
                                                                  DateTime.now()
                                                                      .month,
                                                                  DateTime.now()
                                                                      .day,
                                                                  startTime
                                                                      .hour,
                                                                  startTime
                                                                      .minute),
                                                              endTime: DateTime(
                                                                  DateTime.now()
                                                                      .year,
                                                                  DateTime.now()
                                                                      .month,
                                                                  DateTime.now()
                                                                      .day,
                                                                  endTime.hour,
                                                                  endTime
                                                                      .minute),
                                                              title: title,
                                                              date: date,
                                                            ));
                                                      },
                                                    );
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: TextRegular(
                                                      text: 'Add',
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: TextRegular(
                                                      text: 'Cancel',
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            );
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      timer(),
                      const SizedBox(
                        height: 20,
                      ),
                      isMusicPlaying
                          ? MusicComponent(videoId: urlController.text)
                          : music(),
                      const SizedBox(
                        height: 20,
                      ),
                      todoList(),
                    ],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        settingsDialog(),
                        const SizedBox(
                          height: 20,
                        ),
                        stickyNotes(),
                      ]),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget todoList() {
    return todolistClicked
        ? Container(
            height: 200,
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextRegular(
                          text: 'To-Do',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              todolistClicked = !todolistClicked;
                            });
                          },
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                todos.removeAt(index);
                              });
                            },
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.red,
                            ),
                          ),
                          leading: GestureDetector(
                            onTap: () {
                              setState(() {
                                todos[index]['isCompleted'] =
                                    !todos[index]['isCompleted'];
                              });
                            },
                            child: Icon(
                              todos[index]['isCompleted']
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank_rounded,
                              color: todos[index]['isCompleted']
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                          title: TextRegular(
                            text: todos[index]['title'],
                            fontSize: 18,
                            color: todos[index]['isCompleted']
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: TextRegular(
                                  text: 'Enter ToDo',
                                  fontSize: 14,
                                  color: Colors.black),
                              content: TextFormField(
                                controller: todoController,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        todos.add({
                                          'title': todoController.text,
                                          'isCompleted': false
                                        });
                                      });

                                      todoController.clear();

                                      Navigator.pop(context);
                                    },
                                    child: TextRegular(
                                        text: 'Continue',
                                        fontSize: 14,
                                        color: Colors.black))
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.grey,
                      ),
                      label: TextRegular(
                        text: 'Add task',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          )
        : const SizedBox(
            width: 300,
          );
  }

  Widget timer() {
    return timerClicked
        ? Container(
            height: 160,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextRegular(
                          text: 'Timer',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              timerClicked = !timerClicked;
                            });
                          },
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 20),
                  child: Row(
                    children: [
                      TextBold(
                          text:
                              formatDuration(Duration(seconds: countdownValue)),
                          fontSize: 42,
                          color: Colors.grey),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isPlaying = !isPlaying;
                            if (isPlaying) {
                              startCountdownTimer();
                            } else {
                              stopCountdownTimer();
                            }
                          });
                        },
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_circle_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            stopCountdownTimer();
                            startCountdownTimer();
                          });
                        },
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isPomodoro = true;
                          isShortBreak = false;
                          isLongBreak = false;
                        });
                      },
                      child: TextRegular(
                        text: 'Pomodoro',
                        fontSize: 12,
                        color: isPomodoro ? Colors.blue : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30, child: VerticalDivider()),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isPomodoro = false;
                          isShortBreak = true;
                          isLongBreak = false;
                        });
                      },
                      child: TextRegular(
                        text: 'Short Break',
                        fontSize: 12,
                        color: isShortBreak ? Colors.blue : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30, child: VerticalDivider()),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isPomodoro = false;
                          isShortBreak = false;
                          isLongBreak = true;
                        });
                      },
                      child: TextRegular(
                        text: 'Long Break',
                        fontSize: 12,
                        color: isLongBreak ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  Widget music() {
    return musicClicked
        ? Container(
            height: 170,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextRegular(
                          text: 'Music',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              musicClicked = !musicClicked;
                            });
                          },
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.music_note_rounded,
                              color: Colors.white,
                              size: 48,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 75,
                                child: TextBold(
                                  overFlow: TextOverflow.ellipsis,
                                  text: 'No Title',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              TextBold(
                                text: 'No Author',
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (urlController.text != '') {
                            setState(() {
                              isMusicPlaying = true;
                            });

                            showToast(
                                'Music added to player! Click the play button again to play the music.');
                          } else {
                            showToast('Please enter a valid youtube url!');
                          }
                        },
                        child: const Icon(
                          Icons.play_circle_outlined,
                          color: Colors.grey,
                          size: 32,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 30,
                  width: 250,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: TextFormField(
                    style: const TextStyle(
                        color: Colors.grey,
                        fontFamily: 'QRegular',
                        fontSize: 12),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100)),
                      fillColor: Colors.grey[200],
                      hintText: 'Enter a YouTube URL',
                      border: InputBorder.none,
                    ),
                    controller: urlController,
                  ),
                )
              ],
            ),
          )
        : const SizedBox();
  }

  Widget settingsDialog() {
    final user = FirebaseAuth.instance.currentUser;
    return settingsClicked
        ? Container(
            height: 350,
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextRegular(
                          text: 'Settings',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              settingsClicked = !settingsClicked;
                            });
                          },
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBold(
                          text: 'Hey, @${user!.displayName}',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        TextRegular(
                          text: 'Start customizing your workspace page!',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: GridView.builder(
                        itemCount: backgroundImages.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  backgroundImage = backgroundImages[index];
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image:
                                          AssetImage(backgroundImages[index]),
                                      fit: BoxFit.cover),
                                ),
                                height: 50,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut().then((value) {
                            Navigator.pushReplacementNamed(
                                context, Routes().landingscreen);
                          });

                          showToast('Signed out!');
                        },
                        child: TextRegular(
                          text: 'Signout',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.red,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const SizedBox(
                                      width: 150,
                                      child: Text(
                                        'Are you sure you want to delete your account?',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'QBold',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    content: const Text(
                                      'This action cannot be undone',
                                      style: TextStyle(fontFamily: 'QRegular'),
                                    ),
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(
                                              fontFamily: 'QRegular',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance
                                              .signOut()
                                              .then((value) {
                                            user.delete().then((value) {
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  Routes().landingscreen);
                                            });
                                          });
                                          showToast(
                                              'Account deleted succesfully!');
                                        },
                                        child: const Text(
                                          'Continue',
                                          style: TextStyle(
                                              fontFamily: 'QRegular',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ));
                        },
                        child: TextRegular(
                          text: 'Delete Account',
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  Widget stickyNotes() {
    return notesClicked
        ? Container(
            height: 200,
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white, // Set the yellow background color
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Sticky Notes',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white, // Adjust the font color
                            fontFamily: 'QRegular', // Add font weight
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              notesClicked = !notesClicked;
                            });
                          },
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white, // Adjust the font color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextFormField(
                      minLines: 5,
                      maxLines: 5,
                      style: const TextStyle(
                        fontSize: 16, // Adjust the font size
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox(
            width: 300,
          );
  }

  void startCountdownTimer() {
    if (isPomodoro) {
      durationMinutes = 25;
    } else if (isShortBreak) {
      durationMinutes = 5;
    } else if (isLongBreak) {
      durationMinutes = 15;
    }

    final durationSeconds = durationMinutes * 60;
    countdownValue = durationSeconds;

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countdownValue--;
        if (countdownValue <= 0) {
          stopCountdownTimer();
        }
      });
    });
  }

  void stopCountdownTimer() {
    countdownTimer?.cancel();
    countdownValue = 0;
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  late TimeOfDay startTime;
  late DateTime date;
  late TimeOfDay endTime;

  String title = '';

  bool pickedstartTime = false;
  bool pickeddate = false;
  bool pickedendTime = false;

  void datePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: primary,
                onPrimary: Colors.white,
                onSurface: Colors.grey,
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      setState(() {
        date = pickedDate;
        pickeddate = true;
      });
    } else {
      return null;
    }
  }

  void startTimePicker() async {
    TimeOfDay? pickedTime = await showTimePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primary,
              onPrimary: Colors.white,
              onSurface: Colors.grey,
            ),
          ),
          child: child!,
        );
      },
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      setState(() {
        startTime = pickedTime;
      });
    } else {
      return null;
    }
  }

  void endTimePicker() async {
    TimeOfDay? pickedTime = await showTimePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primary,
              onPrimary: Colors.white,
              onSurface: Colors.grey,
            ),
          ),
          child: child!,
        );
      },
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      setState(() {
        endTime = pickedTime;
        pickedendTime = true;
      });
    } else {
      return null;
    }

    setState(() {});
  }
}
