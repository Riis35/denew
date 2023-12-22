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
              children: [_dropdownMenu(size)],
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

  void change(int number) {
    selection.value = number;
  }

  void changeProfile(int number) {
    profile.value = number;
  }

  void changeColor(Color newColor) {
    color.value = newColor;
  }
}

DropdownMenu _dropdownMenu(Size size) {
  return DropdownMenu<IconLabel>(
    leadingIcon: const Icon(
      Icons.settings,
      color: Colors.black,
    ),
    trailingIcon: Icon(
      Icons.arrow_drop_down,
      color: Colors.black,
    ),
    menuStyle: MenuStyle(),
    hintText: "Mods",
    textStyle: GoogleFonts.montserrat(color: Colors.black),
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 13),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)))),
    onSelected: (IconLabel? icon) {
      MainApp.mod = icon!.index;
    },
    dropdownMenuEntries: IconLabel.values.map<DropdownMenuEntry<IconLabel>>(
      (IconLabel icon) {
        return DropdownMenuEntry<IconLabel>(
          value: icon,
          label: icon.label,
          leadingIcon: Icon(icon.icon),
        );
      },
    ).toList(),
  );
}

enum IconLabel {
  none('None', Icons.sentiment_satisfied_outlined),
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud(
    'Cloud',
    Icons.cloud_outlined,
  ),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}


/*
// DropdownMenuEntry labels and values for the first dropdown menu.
enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

// DropdownMenuEntry labels and values for the second dropdown menu.
enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud(
    'Cloud',
    Icons.cloud_outlined,
  ),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  ColorLabel? selectedColor;
  IconLabel? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownMenu<ColorLabel>(
                      initialSelection: ColorLabel.green,
                      controller: colorController,
                      // requestFocusOnTap is enabled/disabled by platforms when it is null.
                      // On mobile platforms, this is false by default. Setting this to true will
                      // trigger focus request on the text field and virtual keyboard will appear
                      // afterward. On desktop platforms however, this defaults to true.
                      requestFocusOnTap: true,
                      label: const Text('Color'),
                      onSelected: (ColorLabel? color) {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                      dropdownMenuEntries: ColorLabel.values
                          .map<DropdownMenuEntry<ColorLabel>>(
                              (ColorLabel color) {
                        return DropdownMenuEntry<ColorLabel>(
                          value: color,
                          label: color.label,
                          enabled: color.label != 'Grey',
                          style: MenuItemButton.styleFrom(
                            foregroundColor: color.color,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(width: 24),
                    DropdownMenu<IconLabel>(
                      controller: iconController,
                      enableFilter: true,
                      requestFocusOnTap: true,
                      leadingIcon: const Icon(Icons.search),
                      label: const Text('Icon'),
                      inputDecorationTheme: const InputDecorationTheme(
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      onSelected: (IconLabel? icon) {
                        setState(() {
                          selectedIcon = icon;
                        });
                      },
                      dropdownMenuEntries:
                          IconLabel.values.map<DropdownMenuEntry<IconLabel>>(
                        (IconLabel icon) {
                          return DropdownMenuEntry<IconLabel>(
                            value: icon,
                            label: icon.label,
                            leadingIcon: Icon(icon.icon),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
              if (selectedColor != null && selectedIcon != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        'You selected a ${selectedColor?.label} ${selectedIcon?.label}'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        selectedIcon?.icon,
                        color: selectedColor?.color,
                      ),
                    )
                  ],
                )
              else
                const Text('Please select a color and an icon.')
            ],
          ),
        ),
      ),
    );
  }
}
*/