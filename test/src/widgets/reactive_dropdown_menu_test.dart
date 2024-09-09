import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_dropdown_menu_testing_widget.dart';

void main() {
  group('ReactiveDropdownMenu Tests', () {
    testWidgets('Dropdown default value is empty if initial value is null', (WidgetTester tester) async {
      const testKey = Key('test-dropdown');
      final form = FormGroup({'dropdown-menu': FormControl<String>()});

      await tester.pumpWidget(
        ReactiveDropdownMenuTestingWidget(
          form: form,
          items: ['one', 'two'],
          widgetKey: testKey,
        ),
      );

      var finder = find.byKey(testKey);
      expect(finder, findsOneWidget);
      expect(tester.firstWidget<DropdownMenu<String>>(finder).initialSelection, null);
    });

    testWidgets('Dropdown initializes with value if initial value is passed', (WidgetTester tester) async {
      const testKey = Key('test-dropdown');
      final form = FormGroup({'dropdown-menu': FormControl<String>(value: 'two')});

      await tester.pumpWidget(
        ReactiveDropdownMenuTestingWidget(
          form: form,
          items: ['one', 'two'],
          widgetKey: testKey,
        ),
      );

      var finder = find.byKey(testKey);
      expect(finder, findsOneWidget);
      expect(tester.firstWidget<DropdownMenu<String>>(finder).initialSelection, 'two');
    });

    testWidgets('Dropdown changes value when control changes value', (WidgetTester tester) async {
      const testKey = Key('test-dropdown');
      final form = FormGroup({'dropdown-menu': FormControl<String>(value: 'one')});

      await tester.pumpWidget(ReactiveDropdownMenuTestingWidget(
        form: form,
        items: ['one', 'two'],
        widgetKey: testKey,
      ));

      form.control('dropdown-menu').value = 'two';
      await tester.pump();

      var finder = find.byKey(testKey);
      expect(finder, findsOneWidget);

      var dropdown = tester.firstWidget<DropdownMenu<String>>(finder);
      expect(dropdown.initialSelection, 'two');
      expect(form.control('dropdown-menu').value, 'two');
    });

    testWidgets('Dropdown disabled when Control is disabled', (WidgetTester tester) async {
      const testKey = Key('test-dropdown');
      final form = FormGroup({'dropdown-menu': FormControl<String>(disabled: true)});

      await tester.pumpWidget(ReactiveDropdownMenuTestingWidget(
        form: form,
        items: ['one', 'two'],
        widgetKey: testKey,
      ));

      var finder = find.byKey(testKey);
      expect(finder, findsOneWidget);

      var dropdown = tester.firstWidget<DropdownMenu<String>>(finder);
      expect(dropdown.enabled, false);
      expect(dropdown.onSelected, null);
    });

    testWidgets('Dropdown is disabled when readOnly is true', (WidgetTester tester) async {
      const testKey = Key('test-dropdown');
      final form = FormGroup({'dropdown-menu': FormControl<String>()});

      await tester.pumpWidget(ReactiveDropdownMenuTestingWidget(
        form: form,
        items: ['one', 'two'],
        readOnly: true,
        widgetKey: testKey,
      ));

      var finder = find.byKey(testKey);
      expect(finder, findsOneWidget);

      var dropdown = tester.firstWidget<DropdownMenu<String>>(finder);
      expect(dropdown.enabled, false);
      expect(dropdown.onSelected, null);
    });

    testWidgets('Dropdown is disabled when form marked as disabled', (WidgetTester tester) async {
      const testKey = Key('test-dropdown');
      final form = FormGroup({'dropdown-menu': FormControl<String>()});

      await tester.pumpWidget(ReactiveDropdownMenuTestingWidget(
        form: form,
        items: ['one', 'two'],
        widgetKey: testKey,
      ));

      form.markAsDisabled();
      await tester.pump();

      var finder = find.byKey(testKey);
      expect(finder, findsOneWidget);

      var dropdown = tester.firstWidget<DropdownMenu<String>>(finder);
      expect(dropdown.enabled, false);
      expect(dropdown.onSelected, isNull);
    });

    testWidgets('Dropdown is enabled when form marked as enabled', (WidgetTester tester) async {
      const testKey = Key('test-dropdown');
      final form = FormGroup({'dropdown-menu': FormControl<String>(disabled: true)});

      await tester.pumpWidget(ReactiveDropdownMenuTestingWidget(
        form: form,
        items: ['one', 'two'],
        widgetKey: testKey,
      ));

      form.markAsEnabled();
      await tester.pump();

      var finder = find.byKey(testKey);
      expect(finder, findsOneWidget);

      var dropdown = tester.firstWidget<DropdownMenu<String>>(finder);
      expect(dropdown.enabled, true);
      expect(dropdown.onSelected, isNotNull);
    });

    testWidgets('Set Dropdown on Changed callback', (WidgetTester tester) async {
      const testKey = Key('test-dropdown');
      final form = FormGroup({'dropdown-menu': FormControl<String>()});

      var callbackCalled = false;
      FormControl<String>? callbackArg;

      void onSelected(FormControl<String> control) {
        callbackCalled = true;
        callbackArg = control;
      }

      await tester.pumpWidget(ReactiveDropdownMenuTestingWidget(
        form: form,
        items: ['one', 'two'],
        onSelected: onSelected,
        widgetKey: testKey,
      ));

      var finder = find.byKey(testKey);
      var dropdown = tester.firstWidget<DropdownMenu<String>>(finder);
      expect(dropdown.enabled, true);
      dropdown.onSelected!('true');
      await tester.pump();

      expect(callbackCalled, true);
      expect(callbackArg, form.control('dropdown-menu'));
    });
  });
}
