import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_dev_fitness_diet/frontend/features/workouts/add_workout_cubit.dart';

class WorkoutDetailsStep extends StatelessWidget {
  const WorkoutDetailsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddWorkoutCubit, AddWorkoutState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Workout Name',
              ),
              initialValue: state.workoutName,
              onChanged: (value) {
                context.read<AddWorkoutCubit>().updateWorkoutName(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a workout name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Time'),
              subtitle: Text(state.selectedTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: state.selectedTime,
                );
                if (picked != null && picked != state.selectedTime) {
                  context.read<AddWorkoutCubit>().updateSelectedTime(picked);
                }
              },
            ),
            ListTile(
              title: const Text('Days'),
              subtitle: Text(state.selectedDates.isEmpty
                  ? 'No days selected'
                  : state.selectedDates
                      .map((date) => _getDayName(date.weekday))
                      .join(', ')),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final DateTimeRange? picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  initialDateRange: state.selectedDates.isEmpty
                      ? null
                      : DateTimeRange(
                          start: state.selectedDates.first,
                          end: state.selectedDates.last,
                        ),
                );
                if (picked != null) {
                  final dates = <DateTime>[];
                  for (var i = 0; i <= picked.duration.inDays; i++) {
                    dates.add(picked.start.add(Duration(days: i)));
                  }
                  context.read<AddWorkoutCubit>().updateSelectedDates(dates);
                }
              },
            ),
          ],
        );
      },
    );
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
} 