import 'package:flutter_bloc/flutter_bloc.dart';

class PortionSizeCubit extends Cubit<double?> {
  PortionSizeCubit() : super(null);

  void updatePortionSize(String value) {
    final portionSize = double.tryParse(value);
    if (portionSize != null && portionSize > 0) {
      emit(portionSize);
    } else {
      emit(null);
    }
  }

  void reset() {
    emit(null);
  }
} 