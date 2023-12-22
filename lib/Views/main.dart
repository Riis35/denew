import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainApp(),
  ));
  doWhenWindowReady(() {
    const initialSize = Size(1920, 1080);
    appWindow.alignment = Alignment.center;
    appWindow.minSize = Size(1080, 720);
    appWindow.show();
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static Controller c = Get.put(Controller());
  static int mod = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 32, 34, 36),
          body: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: size.height * 0.03,
                          width: size.width * 0.86,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(75, 136, 136, 136)),
                          child: MoveWindow(),
                        ),
                        Container(
                          height: size.height * 0.03,
                          width: size.width * 0.14,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(75, 136, 136, 136)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    appWindow.minimize();
                                  },
                                  child: const Text("-",
                                      style: TextStyle(
                                          color: Colors.orangeAccent))),
                              TextButton(
                                  onPressed: () {
                                    appWindow.close();
                                  },
                                  child: const Text("x",
                                      style: TextStyle(
                                          color: Colors.orangeAccent)))
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          topButtons(size, 1, "3D Macro"),
                          topButtons(size, 2, "Analog"),
                          topButtons(size, 3, "RGB"),
                        ],
                      ),
                    ),
                    Container(height: size.height * 0.1),
                    Keyboard(size),
                    Container(height: size.height * 0.05),
                    RGB(size),
                  ],
                ),
              ),
              Container(),
            ],
          )),
    );
  }
}

Obx topButtons(Size size, int number, String writing) {
  //Üstteki 3 Buton
  return Obx(() => Container(
        decoration: number != 2
            ? BoxDecoration(
                border: const Border(
                    right: BorderSide(color: Colors.white, width: 1),
                    left: BorderSide(color: Colors.white, width: 1)),
                color: MainApp.c.selection.value == number
                    ? Colors.grey[700]
                    : Colors.transparent)
            : BoxDecoration(
                color: MainApp.c.selection.value == number
                    ? Colors.grey[700]
                    : Colors.transparent),
        width: size.width * 0.26,
        height: size.height * 0.04,
        child: TextButton(
          onPressed: () {
            MainApp.c.change(number);
          },
          child: Text(
            writing,
            style: GoogleFonts.montserrat(color: Colors.white),
          ),
        ),
      ));
}

Container Keyboard(Size size) {
  //Klavye
  return Container(
    width: size.width * 0.78,
    height: size.height * 0.3,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 255, 144, 15)),
  );
}

Container RGB(Size size) {
  //RGB modu
  return Container(
    width: size.width * 0.78,
    height: size.height * 0.4,
    child: Row(
      //RGB'nin tamamı
      children: [
        Column(
          //Analog ve dijital tuşlar için
          children: [
            Row(
              //Dropbox ve Container için
              children: [
                Obx(() => _dropdownButton(size)),
              ],
            )
          ],
        )
      ],
    ),
  );
}

class Controller extends GetxController {
  var selection = 1.obs;
  var profile = 1.obs;
  var color = Color.fromARGB(255, 222, 222, 222).obs;
  var firstIcon = "None".obs;

  void change(int number) {
    selection.value = number;
  }

  void changeProfile(int number) {
    profile.value = number;
  }

  void changeColor(Color newColor) {
    color.value = newColor;
  }

  void changeIcon(String newMode) {
    firstIcon.value = newMode;
  }
}

//Dropdownlar
DropdownButtonHideUnderline _dropdownButton(Size size) {
  return DropdownButtonHideUnderline(
    child: Container(
      padding: EdgeInsets.all(5),
      width: size.width * 0.17,
      height: size.width * 0.04,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: DropdownButton(
        items: dropdownItems,
        onChanged: (String? value) {
          MainApp.c.changeIcon(value!);
        },
        value: MainApp.c.firstIcon.value,
        borderRadius: BorderRadius.circular(8),
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          color: Colors.black,
        ),
      ),
    ),
  );
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(FontAwesomeIcons.square),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "None",
                style: GoogleFonts.montserrat(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        value: "None"),
    DropdownMenuItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.air_rounded),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Breathing",
                style: GoogleFonts.montserrat(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        value: "Breathing"),
    DropdownMenuItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(FontAwesomeIcons.rainbow),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Rainbow",
                style: GoogleFonts.montserrat(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        value: "Rainbow"),
    DropdownMenuItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.bolt_rounded),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Flash",
                style: GoogleFonts.montserrat(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        value: "Flash"),
    DropdownMenuItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.circle_rounded),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Static",
                style: GoogleFonts.montserrat(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        value: "Static"),
  ];
  return menuItems;
}
