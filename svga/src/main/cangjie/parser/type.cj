/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package svga.parser

public enum PageUpdateMode {
    | pause
    | play
    | release

    public operator func ==(that: PageUpdateMode): Bool {
        match ((this, that)) {
            case (pause, pause) => true
            case (play, play) => true
            case (release, release) => true
            case _ => false
        }
    }

    public operator func !=(that: PageUpdateMode): Bool {
        return !(this == that)
    }

    public func toString(): String {
        match (this) {
            case pause => "pause"
            case play => "play"
            case release => "release"
            case _ => "none"
        }
    }
}

public enum PLAYER_FILL_MODE {
    | forwards
    | backwards

    public operator func ==(that: PLAYER_FILL_MODE): Bool {
        match ((this, that)) {
            case (forwards, forwards) => true
            case (backwards, backwards) => true
            case _ => false
        }
    }

    public operator func !=(that: PLAYER_FILL_MODE): Bool {
        return !(this == that)
    }
}

public enum PLAYER_CONTENT_MODE {
    | AspectFit
    | Fill
    | AspectFill

    public operator func ==(that: PLAYER_CONTENT_MODE): Bool {
        match ((this, that)) {
            case (AspectFit, AspectFit) => true
            case (Fill, Fill) => true
            case (AspectFill, AspectFill) => true
            case _ => false
        }
    }

    public operator func !=(that: PLAYER_CONTENT_MODE): Bool {
        return !(this == that)
    }
}
