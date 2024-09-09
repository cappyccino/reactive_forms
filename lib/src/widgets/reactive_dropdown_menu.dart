import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveDropdownMenu] that contains a [DropdownMenu].
///
/// This is a convenience widget that wraps a [DropdownMenu] widget in a
/// [ReactiveDropdownMenu].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveDropdownMenu<T> extends ReactiveFocusableFormField<T, T> {
  /// Creates a [ReactiveDropdownMenu] that contains a [DropdownMenu].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// Can optionally provide a [validationMessages] argument to customize a
  /// message for different kinds of validation errors.
  ///
  /// If [readOnly] is true, the dropdown will be disabled, and the down arrow
  /// will be grayed out.
  ///
  /// Can optionally provide a [valueAccessor] to set a custom value accessors.
  /// See [ControlValueAccessor].
  ///
  /// Can optionally provide a [showErrors] function to customize when to show
  /// validation messages. Reactive Widgets make validation messages visible
  /// when the control is INVALID and TOUCHED, this behavior can be customized
  /// in the [showErrors] function.
  ///
  /// ### Example:
  /// Binds a text field.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveDropdownMenu(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveDropdownMenu(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveDropdownMenu(
  ///   formControlName: 'email',
  ///   validationMessages: {
  ///     ValidationMessage.required: 'The email must not be empty',
  ///     ValidationMessage.email: 'The email must be a valid email',
  ///   }
  /// ),
  /// ```
  ///
  /// Customize when to show up validation messages.
  /// ```dart
  /// ReactiveDropdownMenu(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [DropdownMenu] class
  /// and [DropdownMenu], the constructor.
  ReactiveDropdownMenu({
    super.key,
    Key? widgetKey,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    super.focusNode,

    //////////////////////////////////////////////////////////////////////////
    required List<DropdownMenuEntry<T>> dropdownMenuEntries,
    double? width,
    double? menuHeight,
    Widget? leadingIcon,
    Widget? trailingIcon,
    Widget? label,
    String? hintText,
    String? helperText,
    Widget? selectedTrailingIcon,
    bool enableFilter = false,
    bool enableSearch = true,
    bool readOnly = false,
    TextStyle? textStyle,
    InputDecorationTheme? inputDecorationTheme,
    MenuStyle? menuStyle,
    TextEditingController? controller,
    ReactiveFormFieldCallback<T>? onSelected,
    bool? requestFocusOnTap,
    EdgeInsets? expandedInsets,
    SearchCallback<T>? searchCallback,
    List<TextInputFormatter>? inputFormatters,
  }) : super(
          builder: (field) {
            final isEnabled = !(readOnly || field.control.disabled);

            return DropdownMenu<T>(
              key: widgetKey,
              enabled: isEnabled,
              width: width,
              menuHeight: menuHeight,
              leadingIcon: leadingIcon,
              trailingIcon: trailingIcon,
              label: label,
              hintText: hintText,
              helperText: helperText,
              errorText: field.errorText,
              selectedTrailingIcon: selectedTrailingIcon,
              enableFilter: enableFilter,
              enableSearch: enableSearch,
              textStyle: textStyle,
              inputDecorationTheme: inputDecorationTheme,
              menuStyle: menuStyle,
              controller: controller,
              initialSelection: field.value,
              onSelected: isEnabled
                  ? (value) {
                      field.didChange(value);
                      onSelected?.call(field.control);
                    }
                  : null,
              focusNode: field.focusNode,
              requestFocusOnTap: requestFocusOnTap,
              dropdownMenuEntries: dropdownMenuEntries,
              expandedInsets: expandedInsets,
              searchCallback: searchCallback,
              inputFormatters: inputFormatters,
            );
          },
        );
}
