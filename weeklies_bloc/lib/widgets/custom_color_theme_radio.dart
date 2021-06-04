import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';

class ColorThemeRadioIcon extends StatelessWidget {
  final ColorThemeRadio item;

  ColorThemeRadioIcon(this.item);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      if (state is TasksLoadSuccess) {
        return Container(
          child: Container(
            child: Column(
              children: [
                Container(color: item.theme.high),
                Container(color: item.theme.medHigh),
                Container(color: item.theme.med),
                Container(color: item.theme.lowMed),
                Container(color: item.theme.low),
              ],
            ),
            constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  item.theme.high,
                  item.theme.medHigh,
                  item.theme.med,
                  item.theme.lowMed,
                  item.theme.low,
                ],
              ),
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.all(4),
          ),
          decoration: BoxDecoration(
            //color: item.theme.low,
            shape: BoxShape.circle,
            border: item.isSelected
                ? Border.all(
                    color: Colors.white,
                    width: 2,
                  )
                : null,
          ),
        );
      } else {
        return Container();
      }
    });
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
    colorThemeRadios = [];
    switch (selected) {
      case ColorThemeOption.theme1:
        colorThemeRadios
            .add(ColorThemeRadio(true, ColorThemeOption.theme1.colorTheme));
        colorThemeRadios
            .add(ColorThemeRadio(false, ColorThemeOption.theme2.colorTheme));
        break;
      case ColorThemeOption.theme2:
        colorThemeRadios
            .add(ColorThemeRadio(false, ColorThemeOption.theme1.colorTheme));
        colorThemeRadios
            .add(ColorThemeRadio(true, ColorThemeOption.theme2.colorTheme));
        break;
    }
  }
}
