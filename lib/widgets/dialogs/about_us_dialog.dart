import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../text_widget.dart';

class AboutusDialog extends StatelessWidget {
  const AboutusDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 325,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: primaryGrey,
                        )),
                  ),
                ),
                const Center(
                    child: Text(
                  'ABOUT US',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                      color: primaryGrey,
                      fontFamily: 'QBold',
                      fontWeight: FontWeight.w600),
                )),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: TextBold(
                      text: 'Hello,',
                      fontSize: 28,
                      color: secondary,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  child: SizedBox(
                    height: 200,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextRegular(
                            text:
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                            fontSize: 12,
                            color: primaryGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextBold(text: 'Contacts:', fontSize: 14, color: Colors.white),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.call,
                          color: Colors.grey,
                          size: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextRegular(
                      text: '+63XX-XXX-XXXX',
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.email,
                          color: Colors.grey,
                          size: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextRegular(
                      text: 'charlie@mma.com',
                      fontSize: 12,
                      color: Colors.white,
                    ),
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
    );
  }
}
