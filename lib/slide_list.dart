import 'dart:math';

import 'package:animate/scroll_list.dart';
import 'package:flutter/material.dart';

import 'data.dart';

class SlideList extends StatefulWidget {
  const SlideList({Key? key}) : super(key: key);

  @override
  State<SlideList> createState() => _SlideListState();
}

class _SlideListState extends State<SlideList> {
  final _controller = PageController();

  final _notifierScroll = ValueNotifier(0.0);

  void _listener() {
    _notifierScroll.value = _controller.page!;
  }

  @override
  void initState() {
    _controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    super.dispose();
  }

  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        centerTitle: true,
        title: const Text("Animation List Flutter"),
      ),
      body: Stack(children: [
        ValueListenableBuilder<double>(
          valueListenable: _notifierScroll,
          builder: (context, value, _) {
            return PageView.builder(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              itemCount: pictures.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final picture = pictures[index];
                final percentage = index - value;
                final rotation = percentage.clamp(0.0, 1.0);
                final fixRotation = pow(rotation, 0.5);
                // if (index == 1) {
                //   print(percentage);
                // }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Transform(
                        alignment: Alignment.topLeft,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, .001)
                          ..rotateY(2.0 * fixRotation)
                          ..translate(-rotation * width * 0.8),
                        child: Container(
                          width: width * .9,
                          height: height * .62,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    offset: Offset(0.5, 0.5),
                                    spreadRadius: 8)
                              ],
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: AssetImage(picture.image),
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      picture.title,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      picture.subtitle,
                      style: const TextStyle(fontSize: 20),
                    )
                  ],
                );
              },
            );
          },
        ),
        Positioned(
          bottom: 20,
          left: 50,
          right: 50,
          child: SizedBox(
            height: 60,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(width: 2, color: Colors.black54),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(26),
                      bottomRight: Radius.circular(26))),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 15,
          right: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBottomItem(Icons.list_rounded, 0),
              _buildBottomItem(Icons.photo_camera_rounded, 1),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildBottomItem(IconData icon, index) {
    return IconButton(
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ScrollList()));
      },
      icon: Icon(
        icon,
        color: selectedItem == index ? Colors.white : Colors.black,
        size: 40,
      ),
    );
  }
}
