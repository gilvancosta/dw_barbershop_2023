import 'package:dw_barbershop_2023/src/core/ui/helpers/form_helper.dart';
import 'package:dw_barbershop_2023/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop_2023/src/core/ui/widgets/avatar_widget.dart';
import 'package:dw_barbershop_2023/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_barbershop_2023/src/features/schedule/schedule_state.dart';
import 'package:dw_barbershop_2023/src/features/schedule/schedule_vm.dart';
import 'package:dw_barbershop_2023/src/features/schedule/widgets/schedule_calendar.dart';
import 'package:dw_barbershop_2023/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class SchedurePage extends ConsumerStatefulWidget {
  const SchedurePage({super.key});

  @override
  ConsumerState<SchedurePage> createState() => _SchedurePageState();
}

class _SchedurePageState extends ConsumerState<SchedurePage> {
  var dateFormat = DateFormat('dd/MM/yyyy');
  var showCalendar = false;
  final formKey = GlobalKey<FormState>();
  final clientEC = TextEditingController();
  final dateEC = TextEditingController();

  @override
  void dispose() {
    clientEC.dispose();
    dateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ModalRoute.of(context)!.settings.arguments as UserModel;

    final scheduleVM = ref.watch(scheduleVmProvider.notifier);

    final employeeData = switch (userModel) {
      UserModelADM(:final workDays, :final workHours) => (workDays: workDays!, workHours: workHours!),
      UserModelEmployee(:final workDays, :final workHours) => (workDays: workDays, workHours: workHours),
    };

    ref.listen(scheduleVmProvider.select((state) => state.status), (_, status) {
      switch (status) {
        case ScheduleStateStatus.initial:
          break;
        case ScheduleStateStatus.success:
          Messages.showSuccess('Cliente agendado com sucesso', context);
          Navigator.of(context).pop();
        case ScheduleStateStatus.error:
          Messages.showError('Erro ao registrar agendamento', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Cliente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  const AvatarWidget(hideUploadButton: true),
                  const SizedBox(height: 32),
                  Text(
                    userModel.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 37),
                  TextFormField(
                    controller: clientEC,
                    validator: Validatorless.required('Nome é obrigatório'),
                    onTapOutside: (_) => context.unfocus(),
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Nome do Cliente'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                      controller: dateEC,
                      validator: Validatorless.required('Data é obrigatório'),
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          showCalendar = true;
                        });
                        context.unfocus();
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Selecione uma data',
                        hintText: 'Selecione uma data',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                          size: 20,
                        ),
                      )),
                  const SizedBox(height: 10),
                  Offstage(
                    offstage: !showCalendar,
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        ScheduleCalendar(
                          cancelPressed: () {
                            setState(() {
                              showCalendar = false;
                            });
                          },
                          okPressed: (DateTime value) {
                            setState(() {
                              dateEC.text = dateFormat.format(value);
                              scheduleVM.dateSelect(value);
                              showCalendar = false;
                            });
                          },
                          workDays: employeeData.workDays,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  HoursPanel.singleSelection(
                    startTime: 6,
                    endTime: 23,
                    onHourPressed: scheduleVM.hourSelect,
                    enabledTimes: employeeData.workHours,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                      ),
                      onPressed: () {
                        switch (formKey.currentState?.validate()) {
                          case null || false:
                            Messages.showError('Dados incompletos', context);
                          case true:
                            final hourSelected = ref.watch(scheduleVmProvider.select((state) => state.scheduleHour != null));

                            if (hourSelected) {
                              scheduleVM.register(userModel: userModel, clientName: clientEC.text);
                            } else {
                              Messages.showError('Por favor selecione um horário de atendimento', context);
                            }
                        }
                      },
                      child: const Text('AGENDAR')),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
