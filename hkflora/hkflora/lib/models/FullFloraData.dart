import 'dart:convert';

class FullFlora {
  final List<FloraItem> engItems;

  FullFlora({required this.engItems});

  factory FullFlora.fromJson(Map<String, dynamic> data) {
    final List<dynamic> engList = data['eng'];

    List<FloraItem> items =
        engList.map((item) => FloraItem.fromJson(item)).toList();

    return FullFlora(engItems: items);
  }

  Map<String, dynamic> toJson() {
    return {
      'eng': engItems.map((item) => item.toJson()).toList(),
    };
  }

  factory FullFlora.readFromStoredJson(Map<String, dynamic> data) {
    final List<dynamic> engList = data['eng'];

    List<FloraItem> items =
        engList.map((item) => FloraItem.readFromStoredJson(item)).toList();

    return FullFlora(engItems: items);
  }
}

class FloraItem {
  final String type;
  final String content;
  final String lang;
  final String displayOrder;
  final List<TableItem>? table;

  FloraItem({
    required this.type,
    required this.content,
    required this.lang,
    required this.displayOrder,
    this.table,
  });

  factory FloraItem.fromJson(Map<String, dynamic> json) {
    List<TableItem>? tableItems;
    if (json['table'] != null) {
      tableItems = (json['table'] as List)
          .map((item) => TableItem.fromJson(item))
          .toList();
    }

    return FloraItem(
      type: json['type'],
      content: json['content'],
      lang: json['lang'],
      displayOrder: json['display_order'],
      table: tableItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'content': content,
      'lang': lang,
      'display_order': displayOrder,
      'table': table?.map((item) => item.toJson()).toList(),
    };
  }

  factory FloraItem.readFromStoredJson(Map<String, dynamic> json) {
    List<TableItem>? tableItems;
    if (json['table'] != null) {
      tableItems = (json['table'] as List)
          .map((item) => TableItem.readFromStoredJson(item))
          .toList();
    }

    return FloraItem(
      type: json['type'],
      content: json['content'],
      lang: json['lang'],
      displayOrder: json['display_order'],
      table: tableItems,
    );
  }
}

class TableItem {
  final String index;
  final String content;
  final Reference? reference;

  TableItem({
    required this.index,
    required this.content,
    this.reference,
  });

  factory TableItem.fromJson(Map<String, dynamic> json) {
    return TableItem(
      index: json['index'],
      content: json['content'],
      reference: json['reference'] != null
          ? Reference.fromJson(json['reference'])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'content': content,
      'reference': reference?.toJson(),
    };
  }


  factory TableItem.readFromStoredJson(Map<String, dynamic> json) {
    return TableItem(
      index: json['index'],
      content: json['content'],
      reference: json['reference'] != null
          ? Reference.readFromStoredJson(json['reference'])
          : null,
    );
  }
}

class Reference {
  final String index;
  final String content;
  final String refType;
  final String refValue;

  Reference({
    required this.index,
    required this.content,
    required this.refType,
    required this.refValue,
  });

  factory Reference.fromJson(Map<String, dynamic> json) {
    return Reference(
      index: json['index'],
      content: json['content'],
      refType: json['ref_type'],
      refValue: json['ref_value'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'content': content,
      'ref_type': refType,
      'ref_value': refValue,
    };
  }

  factory Reference.readFromStoredJson(Map<String, dynamic> json) {
    return Reference(
      index: json['index'],
      content: json['content'],
      refType: json['ref_type'],
      refValue: json['ref_value'],
    );
  }
}
