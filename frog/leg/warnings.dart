// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class MessageKind {
  final String template;
  const MessageKind(this.template);

  static final GENERIC = const MessageKind('#{1}');

  static final NOT_ASSIGNABLE = const MessageKind(
      '#{2} is not assignable to #{1}');
  static final VOID_EXPRESSION = const MessageKind(
      'expression does not yield a value');
  static final VOID_VARIABLE = const MessageKind(
      'variable cannot be of type void');
  static final RETURN_VALUE_IN_VOID = const MessageKind(
      'cannot return value from void function');
  static final RETURN_NOTHING = const MessageKind(
      'value of type #{1} expected');
  static final MISSING_ARGUMENT = const MessageKind(
      'missing argument of type #{1}');
  static final ADDITIONAL_ARGUMENT = const MessageKind(
      'additional argument');
  static final METHOD_NOT_FOUND = const MessageKind(
      'no method named #{2} in class #{1}');
  static final MEMBER_NOT_STATIC = const MessageKind(
      '#{1}.#{2} is not static');
  static final NO_INSTANCE_AVAILABLE = const MessageKind(
      '#{1} is only available in instance methods');

  static final UNREACHABLE_CODE = const MessageKind(
      'unreachable code');
  static final MISSING_RETURN = const MessageKind(
      'missing return');
  static final MAYBE_MISSING_RETURN = const MessageKind(
      'not all paths lead to a return or throw statement');

  static final CANNOT_RESOLVE = const MessageKind(
      'cannot resolve #{1}');
  static final CANNOT_RESOLVE_CONSTRUCTOR = const MessageKind(
      'cannot resolve constructor #{1}');
  static final CANNOT_RESOLVE_TYPE = const MessageKind(
      'cannot resolve type #{1}');
  static final DUPLICATE_DEFINITION = const MessageKind(
      'duplicate definition of #{1}');
  static final NOT_A_TYPE = const MessageKind(
      '#{1} is not a type');
  static final NO_SUPER_IN_OBJECT = const MessageKind(
      "'Object' does not have a superclass");
  static final CANNOT_FIND_CONSTRUCTOR = const MessageKind(
      'cannot find constructor #{1}');
  static final CANNOT_FIND_CONSTRUCTOR2 = const MessageKind(
      'cannot find constructor #{1} or #{2}');
  static final CYCLIC_CLASS_HIERARCHY = const MessageKind(
      '#{1} creates a cycle in the class hierarchy');
  static final INVALID_RECEIVER_IN_INITIALIZER = const MessageKind(
      'field initializer expected');
  static final NO_SUPER_IN_STATIC = const MessageKind(
      "'super' is only available in instance methods");
  static final DUPLICATE_INITIALIZER = const MessageKind(
      'field #{1} is initialized more than once');
  static final ALREADY_INITIALIZED = const MessageKind(
      '#{1} was already initialized here');
  static final INIT_STATIC_FIELD = const MessageKind(
      'cannot initialize static field #{1}');
  static final NOT_A_FIELD = const MessageKind(
      '#{1} is not a field');
  static final CONSTRUCTOR_CALL_EXPECTED = const MessageKind(
      "only call to 'this' or 'super' constructor allowed");
  static final INVALID_FOR_IN = const MessageKind(
      'invalid for-in variable declaration.');
  static final INVALID_INITIALIZER = const MessageKind(
      'invalid initializer');
  static final FUNCTION_WITH_INITIALIZER = const MessageKind(
      'only constructors can have initializers');
  static final REDIRECTING_CONSTRUCTOR_CYCLE = const MessageKind(
      'cyclic constructor redirection');
  static final REDIRECTING_CONSTRUCTOR_HAS_BODY = const MessageKind(
      'redirecting constructor cannot have a body');
  static final REDIRECTING_CONSTRUCTOR_HAS_INITIALIZER = const MessageKind(
      'redirecting constructor cannot have other initializers');
  static final SUPER_INITIALIZER_IN_OBJECT = const MessageKind(
      "'Object' cannot have a super initializer");
  static final DUPLICATE_SUPER_INITIALIZER = const MessageKind(
      'cannot have more than one super initializer');
  static final NO_MATCHING_CONSTRUCTOR = const MessageKind(
      'no matching constructor found');
  static final NO_CONSTRUCTOR = const MessageKind(
      '#{1} is a #{2}, not a constructor');
  static final FIELD_PARAMETER_NOT_ALLOWED = const MessageKind(
      'a field parameter is only allowed in generative constructors');
  static final INVALID_PARAMETER = const MessageKind(
      "cannot resolve parameter");
  static final NOT_INSTANCE_FIELD = const MessageKind(
      '#{1} is not an instance field');
  static final NO_CATCH_NOR_FINALLY = const MessageKind(
      "expected 'catch' or 'finally'");
  static final EMPTY_CATCH_DECLARATION = const MessageKind(
      'expected a variable in catch declaration');
  static final EXTRA_CATCH_DECLARATION = const MessageKind(
      'extra variable in catch declaration');
  static final UNBOUND_LABEL = const MessageKind(
      'cannot resolve label #{1}');
  static final NO_BREAK_TARGET = const MessageKind(
      'break statement not inside switch or loop');
  static final NO_CONTINUE_TARGET = const MessageKind(
      'continue statement not inside loop');
  static final EXISTING_LABEL = const MessageKind(
      'original declaration of duplicate label #{1}');
  static final DUPLICATE_LABEL = const MessageKind(
      'duplicate declaration of label #{1}');
  static final UNUSED_LABEL = const MessageKind(
      'unused label #{1}');
  static final INVALID_CONTINUE = const MessageKind(
      'target of continue is not a loop or switch case');

  static final NOT_A_COMPILE_TIME_CONSTANT = const MessageKind(
      'not a compile-time constant');

  static final NO_SUCH_LIBRARY_MEMBER = const MessageKind(
      '#{1} has no member named #{2}');

  static final CANNOT_INSTANTIATE_INTERFACE = const MessageKind(
      "cannot instantiate interface '#{1}'");

  static final NO_DEFAULT_CLASS = const MessageKind(
      "no default class on enclosing interface '#{1}'");

  toString() => template;
}

class Message {
  final kind;
  final List arguments;
  String message;

  Message(this.kind, this.arguments);

  String toString() {
    if (message === null) {
      message = kind.template;
      int position = 1;
      for (var argument in arguments) {
        String string = slowToString(argument);
        message = message.replaceAll('#{${position++}}', string);
      }
    }
    return message;
  }

  bool operator==(other) {
    if (other is !Message) return false;
    return (kind == other.kind) && (toString() == other.toString());
  }

  String slowToString(object) {
    if (object is SourceString) {
      return object.slowToString();
    } else {
      return object.toString();
    }
  }
}

class TypeWarning {
  final Message message;
  TypeWarning.message(this.message);
  TypeWarning(MessageKind kind, List<Type> arguments)
    : message = new Message(kind, arguments);
  String toString() => message.toString();
}

class ResolutionError {
  final Message message;
  ResolutionError.message(this.message);
  ResolutionError(MessageKind kind, List<Type> arguments)
    : message = new Message(kind, arguments);
  String toString() => message.toString();
}

class ResolutionWarning {
  final Message message;
  ResolutionWarning.message(this.message);
  ResolutionWarning(MessageKind kind, List<Type> arguments)
    : message = new Message(kind, arguments);
  String toString() => message.toString();
}

class CompileTimeConstantError {
  final Message message;
  CompileTimeConstantError.message(this.message);
  CompileTimeConstantError(MessageKind kind, List<Type> arguments)
    : message = new Message(kind, arguments);
  String toString() => message.toString();
}
