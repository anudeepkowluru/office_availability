import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class Storage {
  static Storage instance = null;

  static File jsonFile;
  static Directory dir;
  static String fileName = "officeAvalability.json";
  static bool fileExists = false;
  Map<String, String> fileContent;
  var presets = {"presets": []};
  Storage();

  // Singleton class
  static initialize() {
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      print('dir.path>>>>' + dir.path);
      fileExists = jsonFile.existsSync();
      // clearStorage();
    });
  }

  Storage getInstance() {
    if (instance == null) {
      initialize();
      instance = new Storage();
    }
    return instance;
  }

  void createFile(Map<String, String> content, Directory dir, String fileName) {
    print("Creating file in Dir>> $dir!");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    file.writeAsStringSync(JSON.encode(presets));
    fileExists = true;
    file.writeAsStringSync(JSON.encode(content));
  }

  void writeToFile(String key, String value) {
    print("Writing to file!");
    Map<String, String> content = {key: value};
    if (fileExists) {
      print("File exists");
      Map<String, String> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(JSON.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile(content, dir, fileName);
    }
    fileContent = JSON.decode(jsonFile.readAsStringSync());
    print(fileContent);
  }

  void writeToCart(List list) {
    print("Writing to file!");
    if (fileExists) {
      print("File exists");
      var jsonFileContent = json.decode(jsonFile.readAsStringSync());
      var toRemove = [];
      // Remove item if exists, so that new item is added
      jsonFileContent["cart"].forEach((item) {
        if (item["productId"] == list[0]["productId"]) {
          toRemove.add(item);
        }
      });

      jsonFileContent["cart"].removeWhere((item) => toRemove.contains(item));

      jsonFileContent["cart"].addAll(list);
      jsonFile.writeAsStringSync(JSON.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      createLocations(list, dir, fileName);
    }
  }

  void removeFromCart(List list) {
    print("Removing from Cart!");
    if (fileExists) {
      var jsonFileContent = json.decode(jsonFile.readAsStringSync());
      var toRemove = [];
      jsonFileContent["cart"].forEach((item) {
        if (item["productId"] == list[0]["productId"]) {
          toRemove.add(item);
        }
      });
      jsonFileContent["cart"].removeWhere((item) => toRemove.contains(item));
      jsonFile.writeAsStringSync(JSON.encode(jsonFileContent));
    }
  }

  void clearCart() {
    if (fileExists) {
      var jsonFileContent = json.decode(jsonFile.readAsStringSync());
      var toRemove = [];
      jsonFileContent["cart"].forEach((item) {
        toRemove.add(item);
      });
      jsonFileContent["cart"].removeWhere((item) => toRemove.contains(item));
      jsonFile.writeAsStringSync(JSON.encode(jsonFileContent));
    }
  }

  void createLocations(list, Directory dir, String fileName) {
    print("Creating file in Dir>> $dir!");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    file.writeAsStringSync(JSON.encode(presets));
    var jsonFileContent = json.decode(file.readAsStringSync());
    jsonFileContent["cart"].addAll(list);
    fileExists = true;
    file.writeAsStringSync(JSON.encode(jsonFileContent));
  }

  int getCartLength() {
    if (fileExists) {
      var jsonFileContent = json.decode(jsonFile.readAsStringSync());
      return jsonFileContent["cart"].length;
    } else {
      return 0;
    }
  }

  getCartItems() {
    if (fileExists) {
      var jsonFileContent = json.decode(jsonFile.readAsStringSync());
      return jsonFileContent["cart"];
    } else {
      return 0;
    }
  }

  getFile() {
    if (fileExists) {
      return JSON.decode(jsonFile.readAsStringSync());
    } else {
      List list = [];
      createLocations(list, dir, fileName);
      return JSON.decode(jsonFile.readAsStringSync());
    }
  }

  static clearStorage() {
    Map<String, String> jsonFileContent =
        json.decode(jsonFile.readAsStringSync());

    if (null != jsonFileContent) {
      jsonFileContent.clear();
    }
  }
}
