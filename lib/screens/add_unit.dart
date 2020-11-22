import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_finder/import.dart';

// TODO: новая порода, если нет желанной

class AddUnitScreen extends StatelessWidget {
  AddUnitScreen({@required this.category});

  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/add_unit',
      builder: (_) => this,
      fullscreenDialog: true,
    );
  }

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add Your Pet',
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
      ),
      body: BlocProvider(
        create: (BuildContext context) => AddUnitCubit(
          getRepository<DatabaseRepository>(context),
        ),
        child: AddUnitForm(category: category),
      ),
    );
  }
}

class AddUnitForm extends StatelessWidget {
  AddUnitForm({@required this.category});

  final CategoryModel category;

  final _formKey = GlobalKey<FormState>();
  final _conditionFieldKey = GlobalKey<SelectFieldState<ConditionValue>>();
  final _breedFieldKey = GlobalKey<SelectFieldState<BreedModel>>();
  final _colorFieldKey = GlobalKey<FormFieldState<String>>();
  final _weightFieldKey = GlobalKey<FormFieldState<String>>();
  final _storyFieldKey = GlobalKey<FormFieldState<String>>();
  final _birthdayFieldKey = GlobalKey<FormFieldState<String>>();
  final _addressFieldKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SelectField<ConditionValue>(
                key: _conditionFieldKey,
                tooltip: 'Select Condition',
                label: 'Condition',
                title: 'Select Condition',
                values: ConditionValue.values,
                getValueTitle: getConditionName,
                getValueSubtitle:
                    getConditionDescription, // TODO: description text
              ),
              SelectField<BreedModel>(
                key: _breedFieldKey,
                tooltip: 'Select Breed',
                label: 'Breed by ${category.name}',
                title: 'Select Breed',
                values: category.breeds,
                getValueTitle: (BreedModel value) => value.name,
              ),
              TextFormField(
                key: _addressFieldKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: RequiredValidator(),
                maxLength: 20,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Address',
                  // helperText: '',
                ),
              ),
              // InputDatePickerFormField(
              //   firstDate: DateTime(2000),
              //   lastDate: DateTime.now(),
              //   fieldLabelText: 'Birthday',
              // ), // отказался, т.к. хочу другой формат даты
              TextFormField(
                key: _birthdayFieldKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: MultiValidator([
                  RequiredValidator(),
                  PatternValidator(r'^\d{2}-\d{2}-\d{4}$',
                      errorText: 'this field must be $kDisplayDateFormat'),
                  DateValidator(kDateFormat,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                      errorText: 'this field must be valid date'),
                ]),
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: 'Birthday',
                  helperText: kDisplayDateFormat,
                ),
              ),
              TextFormField(
                key: _colorFieldKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: RequiredValidator(),
                maxLength: 10,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Color',
                  // helperText: '',
                ),
              ),
              TextFormField(
                key: _weightFieldKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: MultiValidator(
                  [
                    RequiredValidator(),
                    PatternValidator(r'^\d*$',
                        errorText: 'this field must be numeric'),
                  ],
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight',
                  helperText: 'in gramms',
                ),
              ),
              TextFormField(
                key: _storyFieldKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: RequiredValidator(),
                maxLength: 160,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Story',
                  // helperText: '',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  final data = AddUnitData(
                    condition: _conditionFieldKey.currentState.value,
                    breedId: _breedFieldKey.currentState.value?.id,
                    color: _getTextValue(_colorFieldKey),
                    weight:
                        int.parse(_getTextValue(_weightFieldKey), radix: 10),
                    story: _getTextValue(_storyFieldKey),
                    imageUrl: 'none', // TODO: [MVP] imageUrl
                    birthday: DateFormat(kDateFormat)
                        .parse(_getTextValue(_birthdayFieldKey), true),
                    address: _getTextValue(_addressFieldKey),
                  );
                  save(() => getBloc<AddUnitCubit>(context).add(data));
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTextValue(GlobalKey<FormFieldState<String>> key) {
    return key.currentState.value.trim();
  }
}
