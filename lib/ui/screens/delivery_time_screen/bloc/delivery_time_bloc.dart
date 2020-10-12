import 'package:built_collection/built_collection.dart';
import 'package:nok_nok/data_access/secure_storage/secure_storage.dart';
import 'package:nok_nok/models/store_delivery_time_slot.dart';
import 'package:nok_nok/ui/routing/build_context_provider.dart';
import 'package:nok_nok/ui/screens/delivery_time_screen/routing/delivery_time_router.dart';
import 'package:nok_nok/ui/utils/utils.dart';

import 'delivery_time_event.dart';
import 'delivery_time_state.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

import 'package:bloc/bloc.dart';

class DeliveryTimeBloc extends Bloc<DeliveryTimeEvent, DeliveryTimeState> {

  // Public methods and properties

  static const int NumberOfItemsPerRow = 2;

  BuildContextProvider buildContextProvider;
  final String address;
  StoreRepository get storeRepository => _storeRepository;

  DeliveryTimeBloc(
    this._storeRepository,
    this.address,
    this._router)
    : super() {
    assert(_router != null);

    reload();
  }

  void reload() {
    dispatch(ReloadDeliveryTimeEvent());
  }

  void navigateBack() {
    if (buildContextProvider == null) {
      print('Build context provider is not set for DeliveryTimeBlock, Unable to navigate to basket.');
    }
    else {
      final context = buildContextProvider.getContext();
      _router.navigateBack(context);
    }
  }

  void purchase(DeliveryTimeSlot timeSlot) {
    dispatch(PostOrderDeliveryTimeEvent(timeSlot));
  }

  static Map<int, List<DeliveryTimeSlot>> buildDayOfWeekToTimeSlotsMap(BuiltList<DeliveryTimeSlot> timeSlots) {
    var dayOfWeekToTimeSlotsMap = Map<int, List<DeliveryTimeSlot>>();

    for (DeliveryTimeSlot timeSlot in timeSlots) {
      if (dayOfWeekToTimeSlotsMap[timeSlot.dayOfWeek] == null) {
        // We've picked the 1st entry for current day of week
        dayOfWeekToTimeSlotsMap[timeSlot.dayOfWeek] = [timeSlot];
      }
      else {
        dayOfWeekToTimeSlotsMap[timeSlot.dayOfWeek].add(timeSlot);
      }
    }

    return dayOfWeekToTimeSlotsMap;
  }

  BuiltList<DeliveryTimeSlotRowInfo> buildRowsFromTimeSlotsMap(Map<int, List<DeliveryTimeSlot>> dayOfWeekToTimeSlotsMap) {
    var result = List<DeliveryTimeSlotRowInfo>();

    if (buildContextProvider == null) {
      print('Build context provider is not set for DeliveryTimeBloc, Unable to build delivery time screen items.');
      return BuiltList<DeliveryTimeSlotRowInfo>.from(result);
    }

    final context = buildContextProvider.getContext();

    for (int dayOfWeek = DayOfWeekMondayIndex;
         dayOfWeek <= DayOfWeekSundayIndex;
         ++dayOfWeek) {
      final currentDayTimeSlots = dayOfWeekToTimeSlotsMap[dayOfWeek];

      if (currentDayTimeSlots != null && currentDayTimeSlots.isNotEmpty) {
        final dayTitle = titleForDayOfWeek(context, dayOfWeek);
        result.add(DeliveryTimeSlotRowInfo(null, dayTitle));

        for (int timeSlotRowIndex = 0;
             timeSlotRowIndex < currentDayTimeSlots.length;
             timeSlotRowIndex += NumberOfItemsPerRow) {
          final lastTimeSlotIndexInCurrentRow = timeSlotRowIndex + NumberOfItemsPerRow;
          var rowTimeSlots = List<DeliveryTimeSlot>();

          for (int timeSlotIndex = timeSlotRowIndex;
          timeSlotIndex < lastTimeSlotIndexInCurrentRow && timeSlotIndex < currentDayTimeSlots.length;
          ++timeSlotIndex) {
            final timeSlotToInsert = currentDayTimeSlots[timeSlotIndex];
            rowTimeSlots.add(timeSlotToInsert);
          }

          result.add(DeliveryTimeSlotRowInfo(BuiltList<DeliveryTimeSlot>.from(rowTimeSlots), null));
        }
      }
    }

    return BuiltList<DeliveryTimeSlotRowInfo>.from(result);
  }

  // Overridden methods and properties

  @override
  DeliveryTimeState get initialState => DeliveryTimeStateLoading();

  @override
  Stream<DeliveryTimeState> mapEventToState(DeliveryTimeEvent event) async* {
    if (event is ReloadDeliveryTimeEvent) {
      yield* _handleReload();
    }
    else if (event is PostOrderDeliveryTimeEvent) {
      yield* _handlePostOrder(event.timeSlot);
    }
  }

  // Internal methods

  Stream<DeliveryTimeState> _handlePostOrder(DeliveryTimeSlot timeSlot) async* {
    final userName = SecureStorage().userName;
    final phoneNumber = SecureStorage().phoneNumber;

    if (buildContextProvider == null) {
      print('Build context provider is not set for DeliveryTimeBloc, Unable to publish an order.');
      yield DeliveryTimeStatePublishingOrder();
      return;
    }

    final context = buildContextProvider.getContext();
    final localizedDayTitle = titleForDayOfWeek(context, timeSlot.dayOfWeek);

    _storeRepository.postOrder(localizedDayTitle, timeSlot, address, userName, phoneNumber)
      .then((String orderId) {
      if (buildContextProvider == null) {
        print('Build context provider is not set for DeliveryTimeBloc, Unable to navigate to order confirmation.');
      }
      else {
        final context = buildContextProvider.getContext();
        _router.navigateToOrderConfirmation(context, orderId);
      }
    });

    yield DeliveryTimeStatePublishingOrder();
  }

  Stream<DeliveryTimeState> _handleReload() async* {
    final loadedTimeSlots = await storeRepository.getDeliveryTimeSlots(address);
    final dayOfWeekToTimeSlotsMap = buildDayOfWeekToTimeSlotsMap(loadedTimeSlots);
    final timeSlotsRows = buildRowsFromTimeSlotsMap(dayOfWeekToTimeSlotsMap);

    yield DeliveryTimeStateLoaded(_storeRepository.getBasket(), timeSlotsRows);
  }

  // Internal fields

  StoreRepository _storeRepository;
  DeliveryTimeScreenRouter _router;

}