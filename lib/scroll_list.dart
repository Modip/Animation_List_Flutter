import 'package:animate/data.dart';
import 'package:animate/slide_list.dart';
import 'package:flutter/material.dart';

class ScrollList extends StatefulWidget {
  const ScrollList({Key? key}) : super(key: key);

  @override
  State<ScrollList> createState() => _ScrollListState();
}

class _ScrollListState extends State<ScrollList> {
  double screenHeight = 0;
  double screenWidth = 0;
  final double itemSize = 250;
  final controller = ScrollController();

  @override
  void onListnerController() {
    //print("controller:${controller.offset}");
    setState(() {});
  }

  @override
  void initState() {
    controller.addListener(onListnerController);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(onListnerController);
    super.dispose();
  }

  int selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        centerTitle: true,
        title: const Text("Animation List Flutter"),
      ),
      body: Stack(
        children: [
          _listView(),
          Positioned(
            bottom: 20,
            left: 50,
            right: 50,
            child: SizedBox(
              height: 60,

              //color: Colors.white,
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
        ],
      ),
    );
  }

  Widget _listView() => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            itemCount: pictures.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final itemOffset = index * itemSize;
              final difference = controller.offset - itemOffset;
              final percent = 1 - (difference / (itemSize / 2));
              double opacity = percent;
              double scale = percent;
              // print("opacity:$opacity");
              // print(itemOffset);
              if (opacity > 1.0) opacity = 1.0;
              if (opacity < 0.0) opacity = 0.0;
              if (scale == 1) scale = 1.0;
              final picture = pictures[index];
              return Opacity(
                opacity: opacity,
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 8, top: 10),
                  height: itemSize,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      image: DecorationImage(
                        image: AssetImage(
                          picture.image,
                        ),
                        fit: BoxFit.cover,
                      )),
                ),
              );
            }),
      );

  Widget _buildBottomItem(IconData icon, index) {
    return IconButton(
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SlideList()));
      },
      icon: Icon(
        icon,
        color: selectedItem == index ? Colors.black : Colors.white,
        size: 40,
      ),
    );
  }
}
