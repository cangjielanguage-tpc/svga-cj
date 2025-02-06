/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package svga.proto

/* interface of oneof groups */
public interface OneofGroup <: ToString & Hashable {
    /* get which case name of oneof group, returns "" if `None`. */
    func which(): String

    /* test which case name of oneof group */
    func which(one: String): Bool { which() == one }

    /* return any set mutable message of oneof group */
    func mutableData(): ?MessageLite

    /* return true if no field is set */
    func isEmpty(): Bool
}