// // ignore_for_file: prefer_interpolation_to_compose_strings
//
// import 'dart:convert';
// import '../../../util/api-list.dart';
// import '../api/server.dart';
// import '../model/response/item_model.dart';
//
// class ItemRepo {
//   static Server server = Server();
//   static ItemModel itemModel = ItemModel();
//   static ItemData itemModelDetails = ItemData();
//
//   static Future<ItemModel?> getItem() async {
//     try {
//       await server
//           .getRequestWithoutToken(
//         endPoint: APIList.itemList! + "?status=5",
//       )
//           .then((response) {
//         if (response != null && response.statusCode == 200) {
//           final jsonResponse = json.decode(response.body);
//           itemModel = ItemModel.fromJson(jsonResponse);
//           return itemModel;
//         }
//       });
//       return itemModel;
//     } catch (e) {
//       return null;
//     }
//   }
//
//   static Future<ItemData?> getItemDetails({required int itemID}) async {
//     try {
//       await server
//           .getRequestWithoutToken(
//         endPoint: APIList.itemDetails! + itemID.toString(),
//       )
//           .then((response) {
//         if (response != null && response.statusCode == 200) {
//           final jsonResponse = json.decode(response.body);
//           itemModelDetails = ItemData.fromJson(jsonResponse['data']);
//           return itemModelDetails;
//         }
//       });
//       return itemModelDetails;
//     } catch (e) {
//       return null;
//     }
//   }
// }
//


// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import '../../../util/api-list.dart';
import '../api/server.dart';
import '../model/response/item_model.dart';

class ItemRepo {
  static Server server = Server();

  // ✅ Always returns safe ItemModel (never null)
  static Future<ItemModel> getItem() async {
    try {
      final response = await server.getRequestWithoutToken(
        endPoint: APIList.itemList! + "?status=5",
      );

      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return ItemModel.fromJson(jsonResponse);
      } else {
        print("❌ getItem(): API error or null response");
      }
    } catch (e) {
      print("❌ getItem(): Exception - $e");
    }

    // ✅ Return safe empty object on failure
    return ItemModel(data: []);
  }

  // ✅ Always returns safe ItemData (never null)
  static Future<ItemData> getItemDetails({required int itemID}) async {
    try {
      final response = await server.getRequestWithoutToken(
        endPoint: APIList.itemDetails! + itemID.toString(),
      );

      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return ItemData.fromJson(jsonResponse['data']);
      } else {
        print("❌ getItemDetails(): API error or null response");
      }
    } catch (e) {
      print("❌ getItemDetails(): Exception - $e");
    }

    // ✅ Return safe empty object on failure
    return ItemData();
  }
}
