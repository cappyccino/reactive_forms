import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveDropdownMenuTestingWidget extends StatelessWidget {
  final FormGroup form;
  final List<String> items;
  final Key? widgetKey;
  final bool readOnly;
  final ReactiveFormFieldCallback<String>? onSelected;

  const ReactiveDropdownMenuTestingWidget({
    super.key,
    this.widgetKey,
    required this.form,
    required this.items,
    this.readOnly = false,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: ReactiveDropdownMenu<String>(
            widgetKey: widgetKey,
            formControlName: 'dropdown-menu',
            readOnly: readOnly,
            onSelected: onSelected,
            dropdownMenuEntries: items.map<DropdownMenuEntry<String>>((String item) {
              return DropdownMenuEntry<String>(
                value: item,
                label: item,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
