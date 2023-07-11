import 'dart:async';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multifocus/widgets/text_widget.dart';

import '../utils/routes.dart';

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
                          child: Column(
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
                                  text: 'Connect your calendar:',
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Center(
                                child: TextBold(
                                  text: 'Icons here',
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 375,
                                child: WeekView(
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
                      music(),
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
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextBold(
                                text: 'Title here',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              TextBold(
                                text: 'Album here',
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
                      const Icon(
                        Icons.skip_previous_rounded,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.play_circle_outlined,
                        color: Colors.grey,
                        size: 32,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.skip_next_rounded,
                        color: Colors.grey,
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
                      hintText: 'Enter Spotify, YouTube, or Apple Music URL',
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
                          text: 'Hey, @Name',
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
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes().landingscreen);
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
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  Routes().landingscreen);
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
                          text: 'Sticky Notes',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              notesClicked = !notesClicked;
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
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    minLines: 5,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
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
      durationMinutes = 30;
    } else if (isShortBreak) {
      durationMinutes = 5;
    } else if (isLongBreak) {
      durationMinutes = 10;
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
}
