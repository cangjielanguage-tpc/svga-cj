/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */

package svga.proto

/**
 * The class is ProtobufException inherited from Exception
 */
public abstract class ProtobufException <: Exception {}

/**
 * The class is InvalidEnumValueException inherited from ProtobufException
 */
public class InvalidEnumValueException <: ProtobufException {
    public InvalidEnumValueException (public let name: String, public let value: Int32) {}

    public prop message: String {
        get() { "The value `${value}` is illegal for the enum type `${name}`" }
    }
}

/**
 * The class is UnmatchedEnumStringException inherited from ProtobufException
 */
public class UnmatchedEnumStringException <: ProtobufException {
    public UnmatchedEnumStringException (public let name: String, public let value: String) {}

    public prop message: String {
        get() { "Enum type `${name}` match `${value}` failed." }
    }
}

/**
 * The class is ParseValueExecption inherited from ProtobufException
 */
public class ParseValueExecption <: ProtobufException {
    public ParseValueExecption(public let name: String, public let reason!: String = "others") {}

    public prop message: String {
        get() { "Failed to parse `${name}`. [${reason}]" }
    }
}

/* Failed to get oneof case */
public class UnexpectedOneofException <: ProtobufException { }
