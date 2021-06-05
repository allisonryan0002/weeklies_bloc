import 'package:flutter/material.dart';
import 'package:weeklies/models/models.dart';

class ColorThemeRadioIcon extends StatelessWidget {
  final ColorThemeRadio item;

  ColorThemeRadioIcon(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: [
            Container(
              color: item.theme.high,
              constraints: BoxConstraints(maxHeight: 10, maxWidth: 50),
            ),
            Container(
              color: item.theme.medHigh,
              constraints: BoxConstraints(maxHeight: 10, maxWidth: 50),
            ),
            Container(
              color: item.theme.med,
              constraints: BoxConstraints(maxHeight: 10, maxWidth: 50),
            ),
            Container(
              color: item.theme.lowMed,
              constraints: BoxConstraints(maxHeight: 10, maxWidth: 50),
            ),
            Container(
              color: item.theme.low,
              constraints: BoxConstraints(maxHeight: 10, maxWidth: 50),
            ),
          ],
        ),
        constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        margin: EdgeInsets.all(4),
      ),
      decoration: BoxDecoration(
        //color: item.theme.low,
        shape: BoxShape.circle,
        border: item.isSelected
            ? Border.all(
                color: Colors.white.withOpacity(0.8),
                width: 2,
              )
            : null,
      ),
    );
  }
}

class CustomColorThemeRadio extends StatefulWidget {
  final Function(ColorThemeOption) callback;
  final ColorThemeOption initialSelected;

  CustomColorThemeRadio(this.callback, this.initialSelected);

  @override
  _CustomColorThemeRadioState createState() => _CustomColorThemeRadioState();
}

class _CustomColorThemeRadioState extends State<CustomColorThemeRadio> {
  List<ColorThemeRadio> colorThemeRadios = [];
  late ColorThemeOption theme;

  @override
  Widget build(BuildContext context) {
    setupListOfColorThemeRadios(widget.initialSelected);
    return SizedBox(
      width: 250,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          for (int i = 0; i < colorThemeRadios.length; i++)
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(2),
                child: ColorThemeRadioIcon(colorThemeRadios[i]),
              ),
              onTap: () {
                setState(() {
                  colorThemeRadios.forEach((element) {
                    element.isSelected = false;
                  });
                  colorThemeRadios[i].isSelected = true;
                  theme = ColorThemeOption.values[i];
                });
                widget.callback(theme);
              },
            ),
        ],
      ),
    );

    // return SizedBox(
    //   width: 240,
    //   height: 50,
    //   child: ListView.builder(
    //     scrollDirection: Axis.horizontal,
    //     itemCount: colorThemeRadios.length,
    //     itemBuilder: (context, index) {
    //       return IconButton(
    //         splashRadius: 0.1,
    //         onPressed: () {
    //           setState(() {
    //             colorThemeRadios.forEach((element) {
    //               element.isSelected = false;
    //             });
    //             colorThemeRadios[index].isSelected = true;
    //             theme = ColorThemeOption.values[index];
    //           });
    //           widget.callback(theme);
    //         },
    //         icon: ColorThemeRadioIcon(colorThemeRadios[index]),
    //       );
    //     },
    //   ),
    // );
  }

  void setupListOfColorThemeRadios(ColorThemeOption selected) {
    final theme1Radio =
        ColorThemeRadio(false, ColorThemeOption.theme1.colorTheme);
    final theme2Radio =
        ColorThemeRadio(false, ColorThemeOption.theme2.colorTheme);
    final theme3Radio =
        ColorThemeRadio(false, ColorThemeOption.theme3.colorTheme);
    final theme4Radio =
        ColorThemeRadio(false, ColorThemeOption.theme4.colorTheme);
    final theme5Radio =
        ColorThemeRadio(false, ColorThemeOption.theme5.colorTheme);
    colorThemeRadios = [];
    switch (selected) {
      case ColorThemeOption.theme1:
        colorThemeRadios
            .add(ColorThemeRadio(true, ColorThemeOption.theme1.colorTheme));
        colorThemeRadios.add(theme2Radio);
        colorThemeRadios.add(theme3Radio);
        colorThemeRadios.add(theme4Radio);
        colorThemeRadios.add(theme5Radio);
        break;
      case ColorThemeOption.theme2:
        colorThemeRadios.add(theme1Radio);
        colorThemeRadios
            .add(ColorThemeRadio(true, ColorThemeOption.theme2.colorTheme));
        colorThemeRadios.add(theme3Radio);
        colorThemeRadios.add(theme4Radio);
        colorThemeRadios.add(theme5Radio);
        break;
      case ColorThemeOption.theme3:
        colorThemeRadios.add(theme1Radio);
        colorThemeRadios.add(theme2Radio);
        colorThemeRadios
            .add(ColorThemeRadio(true, ColorThemeOption.theme3.colorTheme));
        colorThemeRadios.add(theme4Radio);
        colorThemeRadios.add(theme5Radio);
        break;
      case ColorThemeOption.theme4:
        colorThemeRadios.add(theme1Radio);
        colorThemeRadios.add(theme2Radio);
        colorThemeRadios.add(theme3Radio);
        colorThemeRadios
            .add(ColorThemeRadio(true, ColorThemeOption.theme4.colorTheme));
        colorThemeRadios.add(theme5Radio);
        break;
      case ColorThemeOption.theme5:
        colorThemeRadios.add(theme1Radio);
        colorThemeRadios.add(theme2Radio);
        colorThemeRadios.add(theme3Radio);
        colorThemeRadios.add(theme4Radio);
        colorThemeRadios
            .add(ColorThemeRadio(true, ColorThemeOption.theme5.colorTheme));
        break;
    }
  }
}
