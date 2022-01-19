import 'package:flutter/material.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/utility/utility.dart';

// Circular material element representing 5 colors of the [ColorThemeRadio]
// model
class ColorThemeRadioIcon extends StatelessWidget {
  const ColorThemeRadioIcon(this.model, {Key? key}) : super(key: key);

  final ColorThemeRadio model;

  // Each of the 5 colors are layered in a column that is clipped into a circle
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: model.isSelected
            ? Border.all(
                color: Colors.white.withOpacity(0.8),
                width: 2,
              )
            : null,
      ),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 50, maxWidth: 50),
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        margin: const EdgeInsets.all(4),
        child: Column(
          children: [
            Container(
              color: model.theme.high,
              constraints: const BoxConstraints(maxHeight: 10, maxWidth: 50),
            ),
            Container(
              color: model.theme.medHigh,
              constraints: const BoxConstraints(maxHeight: 10, maxWidth: 50),
            ),
            Container(
              color: model.theme.med,
              constraints: const BoxConstraints(maxHeight: 10, maxWidth: 50),
            ),
            Container(
              color: model.theme.lowMed,
              constraints: const BoxConstraints(maxHeight: 10, maxWidth: 50),
            ),
            Container(
              color: model.theme.low,
              constraints: const BoxConstraints(maxHeight: 10, maxWidth: 50),
            ),
          ],
        ),
      ),
    );
  }
}

// Displays set of [ColorThemeRadioIcon]s in a horizontally wrapping list
class CustomColorThemeRadio extends StatefulWidget {
  const CustomColorThemeRadio(this.callback, this.initialSelected, {Key? key})
      : super(key: key);

  // Relays currently selected [ColorThemeOption] to [HomePage]
  final Function(ColorThemeOption) callback;

  // When [CustomColorThemeRadio] is being built display this [ColorThemeOption]
  // as the initially selected [ColorThemeRadioIcon]
  final ColorThemeOption initialSelected;

  @override
  CustomColorThemeRadioState createState() => CustomColorThemeRadioState();
}

class CustomColorThemeRadioState extends State<CustomColorThemeRadio> {
  // List of [ColorThemeRadio] models for the [ColorThemeRadioIcon]s to be built
  // from
  late List<ColorThemeRadio> colorThemeRadios;

  // Stores the selected [ColorThemeRadioIcon]s corresponding [ColorThemeOption]
  // to be passed into the callback function upon selecting a
  // [ColorThemeRadioIcons]
  late ColorThemeOption theme;

  // Setup colorThemeRadios list with [ColorThemeRadio]s based on the
  // initialSelected
  @override
  void initState() {
    super.initState();
    colorThemeRadios = generateColorThemeRadioList(widget.initialSelected);
  }

  // [SizedBox] containing [ColorThemeRadioIcon] buttons wrapped horizontally
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          for (int i = 0; i < colorThemeRadios.length; i++)
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(3),
                child: ColorThemeRadioIcon(colorThemeRadios[i]),
              ),
              // Ensure only one button is selected at a time & rebuild to
              // update
              onTap: () {
                setState(() {
                  for (final radio in colorThemeRadios) {
                    radio.isSelected = false;
                  }
                  colorThemeRadios[i].isSelected = true;
                  theme = ColorThemeOption.values[i];
                });
                widget.callback(theme);
              },
            ),
        ],
      ),
    );
  }
}
