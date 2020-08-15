import 'dart:convert';

import 'package:built_collection/built_collection.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class TrelloHttpClient {

  // Public methods and properties

  static Future<String> createCard(String title, BuiltList<String> checklistItems) async {
    final createCardUrl = _BaseUrl + _EndpointCards;

    // Create card
    var cardParams = _prepareParams();
    cardParams[_RequestKeyBoardId] = _BoardId;
    cardParams[_RequestKeyColumnId] = _PendingColumnId;
    cardParams[_RequestKeyName] = title;

    final createCardResponse = await http.post(createCardUrl, body: cardParams);
    final cardId = _getIdFromResponse(createCardResponse);

    if (cardId == null) {
      return null;
    }

    if (checklistItems == null || checklistItems.isEmpty) {
      return cardId;
    }

    // Create checklist and attach it to card
    final createCheckListUrl = _BaseUrl + _EndpointChecklists;

    var checklistParams = _prepareParams();
    checklistParams[_RequestKeyBoardId] = _BoardId;
    checklistParams[_RequestKeyCardId] = cardId;

    final createChecklistResponse = await http.post(createCheckListUrl, body: checklistParams);
    final checkListId = _getIdFromResponse(createChecklistResponse);

    if (checkListId == null) {
      return null;
    }

    // Fill checklist with items.

    final createCheckListItemUrl = '$_BaseUrl$_EndpointCards/$cardId/checklist/$checkListId/$_EndpointChecklistItem';

    for (final checkListItem in checklistItems) {
      var checklistItemParams = _prepareParams();
      checklistItemParams[_RequestKeyName] = checkListItem;

      final currentChecklistResponse = await http.post(createCheckListItemUrl, body: checklistItemParams);
      final checklistItemId = _getIdFromResponse(currentChecklistResponse);

      if (checklistItemId == null) {
        return null;
      }
    }

    return cardId;
  }

  // Internal methods

  static Map<String, String> _prepareParams() {
    var result = {_RequestKeyAPIKey : _ApiKey,
                  _RequestKeyAccessToken : _AccessToken};
    return result;
  }

  static String _getIdFromResponse(Response response) {
    if (!_responseSucceeded(response)) {
      return null;
    }
    else {
      final responseJson = json.decode(response.body);
      final cardId = responseJson[_ResponseKeyCardId];

      return cardId;
    }
  }

  static bool _responseSucceeded(Response response) {
    final result = response.statusCode >= 200 && response.statusCode < 400;
    return result;
  }

  // Internal fields

  static const _BaseUrl = 'https://trello.com/1/';
  static const _EndpointCards = 'cards';
  static const _EndpointChecklists = 'checklists';
  static const _EndpointChecklistItem = 'checkItem';

  static const _RequestKeyAPIKey = 'key';
  static const _RequestKeyAccessToken = 'token';
  static const _RequestKeyBoardId = 'idBoard';
  static const _RequestKeyCardId = 'idCard';
  static const _RequestKeyColumnId = 'idList';
  static const _RequestKeyName = 'name';

  static const _ResponseKeyCardId = 'id';

  static const _BoardId = '5f3853696e1dba7d06720bce';
  static const _PendingColumnId = '5f385384ccf75175220cc247';
  static const _ApiKey = '3dcf0470efdb98f287d7a2c6179a9eae';
  static const _AccessToken = '876634305f57bfbe139870e6b0d6f53ed85387d9117c9f6c806e2274e2449a9f';

}