import 'dart:io';

void main() {
  print("ቁጥር አስገባ:");
  String? take = stdin.readLineSync()?.trim();
  if (take != null) {
    print(geezifier(take).split("").join(" "));
  } else {
    return print("Null cant be an intiger");
  }
}

Map<String, String> number = {
  "1": "፩",
  "2": "፪",
  "3": "፫",
  "4": "፬",
  "5": "፭",
  "6": "፮",
  "7": "፯",
  "8": "፰",
  "9": "፱",
  "10": "፲",
  "20": "፳",
  "30": "፴",
  "40": "፵",
  "50": "፶",
  "60": "፷",
  "70": "፸",
  "80": "፹",
  "90": "፺",
  "100": "፻",
  "10000": "፼"
};

String geezifier(String take) {
  if (number.containsKey(take)) {
    return number[take] ?? "Unknown";
  } else {
    String input = take.split("").reversed.join();
    int base = int.parse(take);

    int l = input.length;
    List<String> o = [];
    for (int i = 0; i * 2 <= l; i++) {
      try {
        o.add(input.substring(i * 2, (i * 2) + 2));
      } catch (e) {
        o.add(input[l - 1]);
      }
    }

    List<Map> o2 = [];
    for (String i in o) {
      i.length == 2
          ? o2.add({
              "tens": "${i.split("")[1]}0",
              "once": i.split("")[0],
            })
          : o2.add({"once": i.split("")[0]});
    }

    List o3 = [];
    for (Map v in o2) {
      int parity = o2.indexWhere((element) => element == v);
      if (v["tens"] != null) {
        if (v["tens"] != "00" && v["once"] != "0" && v["once"] != "00") {
          String m =
              "${number[v["tens"]] ?? ""}${number[v["once"]] ?? ""}${parity.isOdd ? number["100"] : parity != 0 ? number["10000"] : ""}";
          o3.add(m);
        } else {
          if (base >= 100000) {
            o3 = [
              "${geezifier((base / 10000).toStringAsFixed(0))} ${number["10000"]} ${(base % 10000) != 0 ? geezifier("${(base % 10000)}") : ""}"
            ];
          } else {
            String m =
                "${number[v["tens"]] ?? ""}${number[v["once"]] ?? ""}${parity.isOdd ? number["100"] : parity != 0 ? number["10000"] : ""}";
            o3.add(m);
          }
        }
      } else {
        if (input
                .toString()
                .split("")
                .where((element) => element != "0")
                .length >
            1) {
          if (base.toString().length < 6) {
            String m =
                "${number[v["once"]] ?? ""}${parity.isOdd ? number["100"] : parity != 0 ? number["10000"] : ""}";

            o3.add(m);
          }
        } else {
          if (base >= 1000000) {
            return "${number["100"]}${number[(base / 100).toStringAsFixed(0)]}";
          } else {
            return "${number[(base / 100).toStringAsFixed(0)]}${number["100"]}";
          }
        }
      }
    }

    if (o3.last[0] == "፩") {
      o3.replaceRange(o3.length - 1, o3.length, [o3.last[1]]);
    }
    return o3.reversed.join();
  }
}
