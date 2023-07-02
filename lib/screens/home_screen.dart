import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:multifocus/widgets/text_widget.dart';

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
  final urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/3.jpg',
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
                  width: 450,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
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
                              color:
                                  calendarClicked ? Colors.black : Colors.grey,
                              fontFamily: 'QRegular',
                            ),
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: VerticalDivider(),
                      ),
                      TextButton(
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
                              color:
                                  todolistClicked ? Colors.black : Colors.grey,
                              fontFamily: 'QRegular',
                            ),
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: VerticalDivider(),
                      ),
                      TextButton(
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
                              color: timerClicked ? Colors.black : Colors.grey,
                              fontFamily: 'QRegular',
                            ),
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: VerticalDivider(),
                      ),
                      TextButton(
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
                              color: musicClicked ? Colors.black : Colors.grey,
                              fontFamily: 'QRegular',
                            ),
                          )),
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
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(
                            Icons.check_box_outline_blank_rounded,
                            color: Colors.grey,
                          ),
                          title: TextRegular(
                            text: 'Sample Task',
                            fontSize: 18,
                            color: Colors.grey,
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
                      onPressed: () {},
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
                      TextBold(text: '5:00', fontSize: 42, color: Colors.grey),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      const Icon(
                        Icons.play_circle_outlined,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.refresh,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: TextRegular(
                        text: 'Pomodoro',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30, child: VerticalDivider()),
                    TextButton(
                      onPressed: () {},
                      child: TextRegular(
                        text: 'Short Break',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30, child: VerticalDivider()),
                    TextButton(
                      onPressed: () {},
                      child: TextRegular(
                        text: 'Long Break',
                        fontSize: 12,
                        color: Colors.grey,
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
}
