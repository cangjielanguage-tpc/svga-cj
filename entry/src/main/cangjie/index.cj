package ohos_app_cangjie_entry

internal import ohos.base.*
internal import ohos.component.*
internal import ohos.state_manage.*
import ohos.state_macro_manage.*
internal import ohos.ability.AbilityContext
import svga.*
import svga.player.*
import svga.parser.PageUpdateMode
import ohos.animator.AnimatorFill
import ohos.hilog.Hilog
import svga.parser.PLAYER_CONTENT_MODE
import std.sync.Timer
import svga.model.*
import svga.proto.Transform
import ohos.image.SourceOptions
import ohos.image.ImageSource
import ohos.image.createImageSource

@Entry
@Component
class EntryView {
    @State
    var flagtest: Bool = false
    var listScroller: Scroller = Scroller()
    func onFinishedCallback(): Unit {
        Hilog.error(0, "test", "onFinished")
    }
    func onFrameCallback(frame: Float64): Unit {
        Hilog.error(0, "test", "onFrame frame:${frame}")
    }
    func onPercentageCallback(percentage: Float64): Unit {
        Hilog.error(0, "test", "onPercentage percentage:${percentage}")
    }

    // 目前仓颉能力不支持，PageUpdateMode功能无法实现
    // var controller2: SvgaController = SvgaController(props: SvgaPlayerProps(pageUpdateMode: PageUpdateMode.pause, loops: 1))
    // var controller3: SvgaController = SvgaController(props: SvgaPlayerProps(pageUpdateMode: PageUpdateMode.play, loops: 1))
    // var controller4: SvgaController = SvgaController(props: SvgaPlayerProps(pageUpdateMode: PageUpdateMode.release, loops: 1))
    // func callback2(num: Option<Int32>): Unit {}
    // var controller21: SvgaController = SvgaController(props: SvgaPlayerProps(pageUpdateMode: PageUpdateMode.release))

    @State
    var buttonIndex = 1
    var controller1: SvgaController = SvgaController()
    var controller5: SvgaController = SvgaController(props: SvgaPlayerProps(loops: 2))
    var controller6: SvgaController = SvgaController(props: SvgaPlayerProps(autoRelease: false))
    var controller7: SvgaController = SvgaController(props: SvgaPlayerProps(clearsAfterStop: true, loops: 1))
    var controller8: SvgaController = SvgaController(
        props: SvgaPlayerProps(clearsAfterStop: false, loops: 1, fillMode: AnimatorFill.Forwards))
//    var controller9: SvgaController = SvgaController(
//        props: SvgaPlayerProps(pageUpdateMode: PageUpdateMode.play, loops: 2))
//    var controller10: SvgaController = SvgaController(
//        props: SvgaPlayerProps(pageUpdateMode: PageUpdateMode.play, loops: 2, autoRelease: false))
//    var controller11: SvgaController = SvgaController(
//        props: SvgaPlayerProps(pageUpdateMode: PageUpdateMode.play, loops: 2, autoRelease: false, clearsAfterStop: false))
//    var controller12: SvgaController = SvgaController(
//        props: SvgaPlayerProps(pageUpdateMode: PageUpdateMode.play, loops: 2, autoRelease: false, clearsAfterStop: false,
//            fillMode: AnimatorFill.Backwards))
    var controller10: SvgaController = SvgaController(
        props: SvgaPlayerProps(loops: 2, autoRelease: false))
    var controller11: SvgaController = SvgaController(
        props: SvgaPlayerProps(loops: 2, autoRelease: false, clearsAfterStop: false))
    var controller12: SvgaController = SvgaController(
        props: SvgaPlayerProps(loops: 2, autoRelease: false, clearsAfterStop: false,
            fillMode: AnimatorFill.Backwards))
    @State
    var url13: String = "angel.svga"
    var controller13: SvgaController = SvgaController()
    var controller14: SvgaController = SvgaController()
    var controller15: SvgaController = SvgaController()
    var controller16: SvgaController = SvgaController()
    var controller17: SvgaController = SvgaController(props: SvgaPlayerProps(loops: 3))
    var controller18: SvgaController = SvgaController(props: SvgaPlayerProps(autoRelease: false))
    var controller19: SvgaController = SvgaController(props: SvgaPlayerProps(clearsAfterStop: false))
    var controller20: SvgaController = SvgaController(props: SvgaPlayerProps(fillMode: AnimatorFill.Backwards))
    var controller22: SvgaController = SvgaController()
    var controller23: SvgaController = SvgaController()
    var controller24: SvgaController = SvgaController()
    var controller25: SvgaController = SvgaController()
    var controller26: SvgaController = SvgaController()
    var controller27: SvgaController = SvgaController()
    var controller28: SvgaController = SvgaController()
    var controller29: SvgaController = SvgaController()
    var controller30: SvgaController = SvgaController()
    var controller31: SvgaController = SvgaController()
    var controller32: SvgaController = SvgaController()
    var controller33: SvgaController = SvgaController()
    var controller34: SvgaController = SvgaController()
    var controller35: SvgaController = SvgaController()
    var controller36: SvgaController = SvgaController()
    var controller37: SvgaController = SvgaController()
    var controller38: SvgaController = SvgaController()
    var controller39: SvgaController = SvgaController()
    var controller40: SvgaController = SvgaController()
    var controller41: SvgaController = SvgaController()
    var controller42: SvgaController = SvgaController()
    var controller43: SvgaController = SvgaController()
    var controller44: SvgaController = SvgaController()
    var controller45: SvgaController = SvgaController()
    var controller46: SvgaController = SvgaController()
    var controller47: SvgaController = SvgaController()
    var controller48: SvgaController = SvgaController()
    var controller49: SvgaController = SvgaController()
    var controller50: SvgaController = SvgaController()
    var controller51: SvgaController = SvgaController()
    var controller52: SvgaController = SvgaController()
    var controller53: SvgaController = SvgaController()
    var controller54: SvgaController = SvgaController()
    var controller55: SvgaController = SvgaController()
    var controller56: SvgaController = SvgaController(props: SvgaPlayerProps(loops: 1))
    var controller57: SvgaController = SvgaController(props: SvgaPlayerProps(loops: 1))
    var controller58: SvgaController = SvgaController(props: SvgaPlayerProps(loops: 1))
    public func build() {
        Column {
            Column {
                Text(flagtest.toString()).id("testText")
                Text("buttonIndex:" + buttonIndex.toString())
                if (buttonIndex == 1) {
                    Column() {
                        SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(),
                            controller: controller1)
                    }
                        .width(200)
                        .height(30.percent) //ok
                //.width(200).height(200) //ok
                //.width(30.percent).height(150) //ok
                //.width(40.percent).height(20.percent) //ok

                //                } else if (buttonIndex == 2) {
                //                    SvgaPlayer(url: "gift3.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller2)
                //                } else if (buttonIndex == 3) {
                //                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller3)
                //                } else if (buttonIndex == 4) {
                //                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller4)
                } else if (buttonIndex == 5) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller5)
                } else if (buttonIndex == 6) {
                    SvgaPlayer(url: "gift3.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller6)
                } else if (buttonIndex == 7) {
                    SvgaPlayer(url: "gift3.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller7)
                } else if (buttonIndex == 8) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller8)
//                } else if (buttonIndex == 9) {
//                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller9)
                } else if (buttonIndex == 10) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller10)
                } else if (buttonIndex == 11) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller11)
                } else if (buttonIndex == 12) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller12)
                } else if (buttonIndex == 13) {
                    SvgaPlayer(url: url13, abilitycontext: globalcontext.getOrThrow(), controller: controller13)
                } else if (buttonIndex == 14) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller14)
                } else if (buttonIndex == 15) {
                    SvgaPlayer(url: "xxxx无效*/@#￥%$", abilitycontext: globalcontext.getOrThrow(),
                        controller: controller15)
                } else if (buttonIndex == 16) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller16)
                } else if (buttonIndex == 17) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller17)
                } else if (buttonIndex == 18) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller18)
                } else if (buttonIndex == 19) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller19)
                } else if (buttonIndex == 20) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller20)
                // } else if (buttonIndex == 21) {
                // SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller21)
                } else if (buttonIndex == 22) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller22)
                } else if (buttonIndex == 23) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller23)
                } else if (buttonIndex == 24) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller24)
                } else if (buttonIndex == 25) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller25)
                } else if (buttonIndex == 26) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller26)
                } else if (buttonIndex == 27) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller27)
                } else if (buttonIndex == 28) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller28)
                } else if (buttonIndex == 29) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller29)
                } else if (buttonIndex == 30) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller30)
                } else if (buttonIndex == 31) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller31)
                } else if (buttonIndex == 32) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller32)
                } else if (buttonIndex == 33) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller33)
                } else if (buttonIndex == 34) {
                    Column() {
                        SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller34)
                    }
                        .width(300)
                        .height(500)
                } else if (buttonIndex == 35) {
                    Column() {
                        SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller35)
                    }
                        .width(300)
                        .height(500)
                } else if (buttonIndex == 36) {
                    Column() {
                        SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller36)
                    }
                        .width(300)
                        .height(500)
                } else if (buttonIndex == 37) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller37)
                } else if (buttonIndex == 38) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller38)
                } else if (buttonIndex == 39) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller39)
                } else if (buttonIndex == 40) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller40)
                } else if (buttonIndex == 41) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller41)
                } else if (buttonIndex == 42) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller42)
                } else if (buttonIndex == 43) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller43)
                } else if (buttonIndex == 44) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller44)
                } else if (buttonIndex == 45) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller45)
                } else if (buttonIndex == 46) {
                    SvgaPlayer(url: "kingset.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller46)
                } else if (buttonIndex == 47) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller47)
                } else if (buttonIndex == 48) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller48)
                } else if (buttonIndex == 49) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller49)
                } else if (buttonIndex == 50) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller50)
                } else if (buttonIndex == 51) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller51)
                } else if (buttonIndex == 52) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller52)
                } else if (buttonIndex == 53) {
                    SvgaPlayer(url: "kingset.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller53)
                } else if (buttonIndex == 54) {
                    SvgaPlayer(url: "kingset.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller54)
                } else if (buttonIndex == 55) {
                    SvgaPlayer(url: "kingset.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller55)
                } else if (buttonIndex == 56) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller56)
                } else if (buttonIndex == 57) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller57)
                } else if (buttonIndex == 58) {
                    SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller58)
                }
            }
                .height(70.percent)
                .width(100.percent)
            List(scroller: this.listScroller) {
                ListItem() {
                    Column(5) {
                        Button('1.SvgaController不带参-OK')
                            .id("EntryView01")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 1
                                    flagtest = true
                                    // 效果为循环播放
                                    Hilog.error(0,"svgatest","1 flagtest：${flagtest}")
                            }

                        //                        // 动画只设置播放一遍，pageUpdateMode设置了pause，然后动画播放过程中，跳转了别的页面，然后返回，发现动画已经没了.
                        //                        Button('2.SvgaController带一个参数pageUpdateMode-pause-功能无效')
                        //                            .width(90.percent)
                        //                            .height(35)
                        //                            .shape(ShapeType.Normal)
                        //                            .backgroundColor(Color.RED)
                        //                            .onClick {
                        //                                =>
                        //                                // 暂停播放,不执行清理
                        //                                flagtest = false
                        //                                //buttonIndex = 2
                        //                                flagtest = true
                        //                                Router.push(url: "Index2")
                        //                                // Router.pushUrl(url: "Index2",mode:RouterMode.Single,callback:callback2)
                        //                                // Router.pushUrl(url: "Index2",mode:RouterMode.Standard,callback:callback2)
                        //                            }
                        //                        Button('3.SvgaController带一个参数pageUpdateMode-play-OK')
                        //                            .width(90.percent)
                        //                            .height(35)
                        //                            .shape(ShapeType.Normal)
                        //                            .backgroundColor(Color.RED)
                        //                            .onClick {
                        //                                =>
                        //                                // 继续播放，不执行清理
                        //                                flagtest = false
                        //                                //buttonIndex = 3
                        //                                Router.push(url: "Index2")
                        //                                flagtest = true
                        //                            }
                        //                        Button('4.SvgaController带一个参数pageUpdateMode-release-功能无效')
                        //                            .width(90.percent)
                        //                            .height(35)
                        //                            .shape(ShapeType.Normal)
                        //                            .backgroundColor(Color.RED)
                        //                            .onClick {
                        //                                =>
                        //                                // 释放资源，执行清理
                        //                                flagtest = false
                        //                                Router.push(url: "Index2")
                        //                                flagtest = true
                        //                            }

                        Button('5.SvgaController带一个参数loops-OK')
                            .id("EntryView02")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 5
                                    flagtest = true
                                    // 效果为播放2遍
                                    Hilog.error(0,"svgatest","5 flagtest：${flagtest}")
                            }
                        Button('6.SvgaController带一个参数autoRelease')
                            .id("EntryView03")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.ORANGE)
                            .onClick {
                                =>
                                    flagtest = false
                                    // 对标库arkts也看不出效果
                                    buttonIndex = 6
                                    flagtest = true
                                    Hilog.error(0,"svgatest","6 flagtest：${flagtest}")
                            }
                        Button('7.SvgaController带一个参数clearsAfterStop-OK')
                            .id("EntryView04")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    // clearsAfterStop设置true，实测效果为动画停止后动画被清空
                                    buttonIndex = 7
                                    flagtest = true
                                    Hilog.error(0,"svgatest","7 flagtest：${flagtest}")
                            }
                        Button('8.SvgaController带一个参数fillMode-OK')
                            .id("EntryView05")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    // AnimatorFill.Backwards 显示播放完成后停在首帧 （需要设置clearsAfterStop: false才能看效果）
                                    // AnimatorFill.Forwards  播放完成后停在尾帧（需要设置clearsAfterStop: false才能看效果）
                                    buttonIndex = 8
                                    flagtest = true
                                    // 效果为播放完成后停在尾帧
                                    Hilog.error(0,"svgatest","8 flagtest：${flagtest}")
                                    this.listScroller.scrollToIndex(1)
                            }
//                        Button('9.SvgaController带1个参数loops-OK')
//                            .width(90.percent)
//                            .height(35)
//                            .shape(ShapeType.Normal)
//                            .backgroundColor(Color.GREEN)
//                            .onClick {
//                                =>
//                                    flagtest = false
//                                    buttonIndex = 9
//                                    flagtest = true
//                                    Hilog.error(0,"svgatest","9 flagtest：${flagtest}")
//                            }
                            }
                        }
                            ListItem() {
                    Column(5) {
                        Button('10.SvgaController带2个loops，autoRelease-OK')
                            .id("EntryView06")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 10
                                    flagtest = true
                                    // 效果为播放2遍
                                    Hilog.error(0,"svgatest","10 flagtest：${flagtest}")
                            }
                        Button('11.SvgaController带3个loops，autoRelease，clearsAfterStop-OK')
                            .id("EntryView07")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 11
                                    flagtest = true
                                    // 效果为播放2遍，停止在最后一帧
                                    Hilog.error(0,"svgatest","11 flagtest：${flagtest}")
                            }
                        Button('12.SvgaController带4个参数loops，autoRelease，clearsAfterStop，fillMode-OK')
                            .id("EntryView08")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 12
                                    flagtest = true
                                    // 效果为播放2遍，停止在第一帧
                                    Hilog.error(0,"svgatest","12 flagtest：${flagtest}")
                            }
                        Button('13-1.SvgaPlayer-updateSource-先显示第一个动画')
                            .id("EntryView09")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 13
                            }
                        Button('13-2.SvgaPlayer-updateSource-切换显示第二个动画')
                            .id("EntryView10")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    url13 = "gift3.svga"
                                    flagtest = true
                                    // 效果为切换到第二个动画
                                    Hilog.error(0,"svgatest","13 flagtest：${flagtest}")
                                    this.listScroller.scrollToIndex(2)
                            }
                            }
                        }
                            ListItem() {
                    Column(5) {
                        Button('14.SvgaPlayer-url传空-OK')
                            .id("EntryView11")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 14
                                    flagtest = true
                                    // 效果为不显示
                                    Hilog.error(0,"svgatest","14 flagtest：${flagtest}")
                            }
                        Button('15.SvgaPlayer-url不传空-传无效值-OK')
                            .id("EntryView12")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 15
                                    flagtest = true
                                    // 效果为不显示
                                    Hilog.error(0,"svgatest","15 flagtest：${flagtest}")
                            }
                        Button('16.SvgaPlayer-url不传空-传有效值')
                            .id("EntryView13")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 16
                                    flagtest = true
                                    // 效果为显示动画
                                    Hilog.error(0,"svgatest","16 flagtest：${flagtest}")
                            }
                        Button('17.获取动画播放次数getloops()')
                            .id("EntryView14")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 17
                                    let result = controller17.getloops()
                                    flagtest = result == 3
                                    // getloops获取的值为3
                                    Hilog.error(0,"svgatest","17 flagtest：${flagtest} getloops:${result}")
                            }
                        Button('18.获取当前是否自动释放动画资源getautoRelease()')
                            .id("EntryView15")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 18
                                    let result = controller18.getautoRelease()
                                    flagtest = result == false
                                    // getautoRelease获取为false
                                    Hilog.error(0,"svgatest","18 flagtest：${flagtest}  getautoRelease false=${result}")
                                    this.listScroller.scrollToIndex(3)
                            }
                             }
                        }
                            ListItem() {
                    Column(5) {
                        Button('19.获取是否在停止后释放资源getclearsAfterStop()')
                            .id("EntryView16")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 19
                                    let result = controller19.getclearsAfterStop()
                                    flagtest = result == false
                                    Hilog.error(0,"svgatest","19 flagtest：${flagtest} getclearsAfterStop false=${result}")
                            }
                        Button('20.获取动画执行后，动画结束时的状态getfillMode()')
                            .id("EntryView17")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 20
                                    match (controller20.getfillMode()) {
                                        case AnimatorFill.Forwards => Hilog.error(0, "test",
                                            "flagtest:${flagtest} getfillMode:AnimatorFill.Forwards")
                                        case AnimatorFill.Backwards =>
                                            flagtest = true
                                            // 期望结果
                                            Hilog.error(0,"svgatest","20 flagtest：${flagtest}")
                                        case _ => Hilog.error(0, "test", "flagtest:${flagtest} getfillMode:Other")
                                    }
                            }
                        //                        Button('21.获取动画播放模式getpageUpdateMode()')
                        //                            .width(90.percent)
                        //                            .height(35)
                        //                            .shape(ShapeType.Normal)
                        //                            .backgroundColor(Color.GREEN)
                        //                            .onClick {
                        //                                =>
                        //                                flagtest = false
                        //								buttonIndex = 21
                        //                                match(controller21.getpageUpdateMode()){
                        //                                    case PageUpdateMode.pause=>
                        //                                    Hilog.error(0,"test","flagtest:${flagtest} getpageUpdateMode:PageUpdateMode.pause")
                        //                                    case PageUpdateMode.play=>
                        //                                    Hilog.error(0,"test","flagtest:${flagtest} getpageUpdateMode:PageUpdateMode.play")
                        //                                    case PageUpdateMode.release=>
                        //                                    flagtest = true
                        //                                    Hilog.error(0,"test","flagtest:${flagtest} getpageUpdateMode:PageUpdateMode.release")
                        //                                }
                        //                            }
                        Button('22.加载动画资源load-1个参数source传空')
                            .id("EntryView18")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 22
                                    controller22.load("")
                                    // 效果为没有动画
                                    flagtest = true
                                    Hilog.error(0,"svgatest","22 flagtest：${flagtest}")
                            }
                        Button('23.加载动画资源load-1个参数source不传空-传无效值')
                            .id("EntryView19")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 23
                                    controller23.load("!@# %￥……我.-*+6")
                                    // 效果为没有动画
                                    flagtest = true
                                    Hilog.error(0,"svgatest","23 flagtest：${flagtest}")
                            }
                        Button('24-1.加载动画资源load-1个参数source不传空-传有效值-先切换')
                            .id("EntryView20")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 24
                                    this.listScroller.scrollToIndex(4)
                            }
                             }
                        }
                            ListItem() {
                    Column(5) {
                          Button('24-2.加载动画资源load-1个参数source不传空-传有效值-再播放')
                            .id("EntryView21")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller24.load("angel.svga")
                                    flagtest = true
                                    //效果为播放动画
                                    Hilog.error(0,"svgatest","24 flagtest：${flagtest}")
                            }
                        Button('25-1.加载动画资源load-2个参数autoPlay设置true')
                            .id("EntryView22")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 25
                            }
                         Button('25-2.加载动画资源load-2个参数autoPlay设置true')
                            .id("EntryView23")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller25.load("angel.svga", autoPlay: true)
                                    flagtest = true
                                    //效果为播放动画
                                    Hilog.error(0,"svgatest","25 flagtest：${flagtest}")
                            }
                        Button('26-1.加载动画资源load-2个参数autoPlay设置false')
                            .id("EntryView24")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 26
                            }
                         Button('26-2.加载动画资源load-2个参数autoPlay设置false')
                            .id("EntryView25")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller26.load("angel.svga", autoPlay: false)
                                    flagtest = true
                                    // 效果为不播放
                                    Hilog.error(0,"svgatest","26 flagtest：${flagtest}")
                                    this.listScroller.scrollToIndex(5)
                            }
                             }
                        }
                            ListItem() {
                    Column(5) {
                        Button('27-1.开始播放动画startAnimation-reverse不设置')
                            .id("EntryView26")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 27

                            }
                        Button('27-2.开始播放动画startAnimation-reverse不设置')
                            .id("EntryView27")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller27.load("angel.svga", autoPlay: false)
                                    controller27.startAnimation()
                                    flagtest = true
                                     // 效果为播放动画，正向播放
                                    Hilog.error(0,"svgatest","27 flagtest：${flagtest}")

                            }
                        Button('28-1.开始播放动画startAnimation-reverse设置true')
                            .id("EntryView28")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 28
                            }
                         Button('28-2.开始播放动画startAnimation-reverse设置true')
                            .id("EntryView29")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller28.load("angel.svga", autoPlay: false)
                                    controller28.startAnimation(reverse: true)
                                    flagtest = true
                                     // 效果为播放动画，反向播放
                                    Hilog.error(0,"svgatest","28 flagtest：${flagtest}")
                            }
                        Button('29-1.初始化')
                            .id("EntryView30")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 29
                                    this.listScroller.scrollToIndex(6)
                            }
                             }
                        }
                            ListItem() {
                    Column(5) {
                        Button('29-2.开始播放动画-startAnimationWithRange-1个参数range')
                            .id("EntryView31")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    // 对标库也不支持load和startAnimationWithRange放一块调用
                                    controller29.load("angel.svga", autoPlay: false)
                                    // 第一个参数是起始播放第几帧，第二个参数是播放长度
                                    let range: SvgaRange = SvgaRange(10.50001, 10.7123) //ok
                                    //let range:SvgaRange=SvgaRange(-10.50001,20.7123) //ok
                                    //let range:SvgaRange=SvgaRange(-0.50001,1020.7123) //ok
                                    //let range:SvgaRange=SvgaRange(0.0,1020.7123) //ok
                                    //let range:SvgaRange=SvgaRange(0.0,0.0) //ok
                                    // let range:SvgaRange=SvgaRange(-1000.50001,20.7123) // ok
                                    //let range:SvgaRange=SvgaRange(-1000.50001,-10200.7123) // ok
                                    //let range:SvgaRange=SvgaRange(-10000.0,1020.7123) // ok
                                    controller29.startAnimationWithRange(range)
                                    flagtest = true
                                    Hilog.error(0,"svgatest","29 flagtest：${flagtest}")
                            }
                           Button('30-1.按钮初始化')
                            .id("EntryView32")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 30
                            }
                        Button('30-2.开始播放动画-startAnimationWithRange-2个参数reverse设置true')
                            .id("EntryView33")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    // 对标库也不支持load和startAnimationWithRange放一块调用
                                    controller30.load("angel.svga", autoPlay: false)
                                    // let range:SvgaRange=SvgaRange(10.0001,100.7123) //ok
                                    // let range:SvgaRange=SvgaRange(10.50001,-100.7123)//ok
                                    let range: SvgaRange = SvgaRange(10.0001, 20.7123) //ok
                                    controller30.startAnimationWithRange(range, reverse: true)
                                    flagtest = true
                                    Hilog.error(0,"svgatest","30 flagtest：${flagtest}")
                            }
                        Button('31-1.暂停动画-pauseAnimation()')
                            .id("EntryView34")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 31
                            }
                           Button('31-2.暂停动画后再次播放')
                            .id("EntryView35")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller31.pauseAnimation()
                                    this.listScroller.scrollToIndex(7)
                            }
                             }
                        }
                            ListItem() {
                    Column(5) {
                        Button('31-3.暂停动画后再次播放')
                            .id("EntryView36")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    // 效果和arkts对标库一致，都是重新播放的
                                    controller31.startAnimation()
                                    flagtest = true
                                    Hilog.error(0,"svgatest","31 flagtest：${flagtest}")
                            }
                      Button('32-1.停止动画-stopAnimation-设置true')
                            .id("EntryView37")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 32
                            }
                        Button('32-2.停止动画-stopAnimation-设置true')
                            .id("EntryView38")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller32.stopAnimation(true)
                                    flagtest = true
                                    Hilog.error(0,"svgatest","32 flagtest：${flagtest}")
                            }
                         Button('33-1.停止动画-stopAnimation-设置false')
                            .id("EntryView39")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 33
                            }
                        Button('33-2.停止动画-stopAnimation-设置false')
                            .id("EntryView40")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller33.stopAnimation(false)
                                    flagtest = true
                                    // 效果为停止播放
                                    Hilog.error(0,"svgatest","33 flagtest：${flagtest}")
                                    this.listScroller.scrollToIndex(8)
                            }
                             }
                        }
                            ListItem() {
                    Column(5) {
                        Button('34-1.初始化设置')
                            .id("EntryView41")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 34
                            }

                        //AspectFit 动画内容完整显示，不裁剪，留空白区域
                        //Fill 动画强行拉伸到容器大小，可能变形
                        //AspectFill 动画内容铺满容器，可能超出一部分被裁剪
                        Button('34-2.设置当前播放模式-setContentMode-AspectFit')
                            .id("EntryView42")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller34.load("angel.svga", autoPlay: false)
                                    //AspectFit 动画内容完整显示，不裁剪，留空白区域
                                    controller34.setContentMode(PLAYER_CONTENT_MODE.AspectFit)
                                    controller34.startAnimation()
                                    flagtest = true
                                    Hilog.error(0,"svgatest","34 flagtest：${flagtest}")
                            }
                          Button('35-1.初始化设置')
                            .id("EntryView43")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                   flagtest = false
                                    buttonIndex = 35
                            }
                        Button('35-2.设置当前播放模式-setContentMode-Fill')
                            .id("EntryView44")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                     controller35.load("angel.svga", autoPlay: false)
                                    //Fill 动画强行拉伸到容器大小，可能变形
                                    controller35.setContentMode(PLAYER_CONTENT_MODE.Fill)
                                    controller35.startAnimation()
                                    flagtest = true
                                    Hilog.error(0,"svgatest","35 flagtest：${flagtest}")
                            }
                            Button('36-1.初始化设置')
                            .id("EntryView45")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 36
                                    this.listScroller.scrollToIndex(9)
                            }
                             }
                        }
                            ListItem() {
                    Column(5) {
                        Button('36-2.设置当前播放模式-setContentMode-AspectFill')
                            .id("EntryView46")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller36.load("angel.svga", autoPlay: false)
                                    //AspectFill 动画内容铺满容器，可能超出一部分被裁剪
                                    controller36.setContentMode(PLAYER_CONTENT_MODE.AspectFill)
                                    controller36.startAnimation()
                                    flagtest = true
                                    Hilog.error(0,"svgatest","36 flagtest：${flagtest}")
                            }
                          Button('37-1.清理动画资源-clear')
                            .id("EntryView47")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 37
                            }
                        Button('37-2.清理动画资源-clear')
                            .id("EntryView48")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller37.clear()
                                    flagtest = true
                                    Hilog.error(0,"svgatest","37 flagtest：${flagtest}")
                            }
                          Button('38-1.从指定位置开始播放-stepToFrame-1个参数frame设置正数')
                            .id("EntryView49")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 38
                            }
                        Button('38-2.从指定位置开始播放-stepToFrame-1个参数frame设置正数')
                            .id("EntryView50")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    //跳转到指定帧（frame），并可选地从该帧开始播放动画。
                                    controller38.stepToFrame(20.001)
                                    flagtest = true
                                    Hilog.error(0,"svgatest","38 flagtest：${flagtest}")
                                    this.listScroller.scrollToIndex(10)
                            }
                             }
                        }
                            ListItem() {
                    Column(5) {
                        Button('39-1.从指定位置开始播放-stepToFrame-1个参数frame设置0')
                            .id("EntryView51")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 39
                            }
                        Button('39-2.从指定位置开始播放-stepToFrame-1个参数frame设置0')
                            .id("EntryView52")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller39.stepToFrame(0.0)
                                    flagtest = true
                                    Hilog.error(0,"svgatest","39 flagtest：${flagtest}")
                            }
                        Button('40-1.从指定位置开始播放-stepToFrame-1个参数frame设置负数')
                            .id("EntryView53")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 40
                            }
                        Button('40-2.从指定位置开始播放-stepToFrame-1个参数frame设置负数')
                            .id("EntryView54")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller40.stepToFrame(-9999.10001)
                                    flagtest = true
                                    Hilog.error(0,"svgatest","40 flagtest：${flagtest}")
                            }
                        Button('41-1.从指定位置开始播放-stepToFrame-2个参数andPlay设置false')
                            .id("EntryView55")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 41
                                    this.listScroller.scrollToIndex(11)
                            }
                             }
                        }
                            ListItem() {
                    Column(5) {
                        Button('41-2.从指定位置开始播放-stepToFrame-2个参数andPlay设置false')
                            .id("EntryView56")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller41.stepToFrame(10.10001, andPlay: false)
                                    flagtest = true
                                    // 效果为停止播放
                                    Hilog.error(0,"svgatest","41 flagtest：${flagtest}")
                            }
                        Button('42-1.从指定百分比开始播放-stepToPercentage-percentage设置正数，andPlay设置true')
                            .id("EntryView57")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 42
                            }
                        Button('42-2.从指定百分比开始播放-stepToPercentage-percentage设置正数，andPlay设置true')
                            .id("EntryView58")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller42.stepToPercentage(0.1, true)
                                    flagtest = true
                                    Hilog.error(0,"svgatest","42 flagtest：${flagtest}")
                            }
                        Button('43-1.从指定百分比开始播放-stepToPercentage-percentage设置0，andPlay设置true')
                            .id("EntryView59")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 43
                            }
                        Button('43-2.从指定百分比开始播放-stepToPercentage-percentage设置0，andPlay设置true')
                            .id("EntryView60")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller43.stepToPercentage(0.0, true)
                                    flagtest = true
                                    Hilog.error(0,"svgatest","43 flagtest：${flagtest}")
                                    this.listScroller.scrollToIndex(12)
                            }
                             }
                        }
                            ListItem() {
                    Column(5) {
                        Button('44-1.从指定百分比开始播放-stepToPercentage-percentage设置负数，andPlay设置true')
                            .id("EntryView61")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 44
                            }
                        Button('44-2.从指定百分比开始播放-stepToPercentage-percentage设置负数，andPlay设置true')
                            .id("EntryView62")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    // 效果同对标库arkts。设置负数，动画一直播放没影响
                                    controller44.stepToPercentage(-9999.00001, true)
                                    flagtest = true
                                    Hilog.error(0,"svgatest","44 flagtest：${flagtest}")
                            }
                        Button('45-1.从指定百分比开始播放-stepToPercentage-andPlay设置false')
                            .id("EntryView63")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 45
                            }
                        Button('45-2.从指定百分比开始播放-stepToPercentage-andPlay设置false')
                            .id("EntryView64")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    // 效果为不播放
                                    controller45.stepToPercentage(0.20001, false)
                                    flagtest = true
                                    Hilog.error(0,"svgatest","45 flagtest：${flagtest}")
                            }
                        Button('46-1.清理动态资源-clearDynamicObjects()')
                            .id("EntryView65")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 46
                                    this.listScroller.scrollToIndex(13)
                            }
                             }
                        }
                            ListItem() {
                    Column(5) {
                        Button('46-2.清理动态资源-clearDynamicObjects()')
                            .id("EntryView66")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller46.setText("1234567890", 'banner');

                                    Timer.once(2000 * Duration.millisecond) {
                                        =>
                                            controller46.clearDynamicObjects()
                                            flagtest = true
                                            Hilog.error(0,"svgatest","46 flagtest：${flagtest}")
                                    }
                            }
                        Button('47-1.设置播放次数setLoops-loops设置负数')
                            .id("EntryView67")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 47
                            }
                        Button('47-2.设置播放次数setLoops-loops设置负数')
                            .id("EntryView68")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    // 效果为一直播放
                                    controller47.setLoops(-10000)
                                    controller47.load("angel.svga", autoPlay: true)
                                    flagtest = true
                                    Hilog.error(0,"svgatest","47 flagtest：${flagtest}")
                            }
                        Button('48-1.设置播放次数setLoops-loops设置0')
                            .id("EntryView69")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 48
                            }
                        Button('48-2.设置播放次数setLoops-loops设置0')
                            .id("EntryView70")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    // 无限循环播放
                                    controller48.setLoops(0)
                                    controller48.load("angel.svga", autoPlay: true)
                                    flagtest = true
                                    Hilog.error(0,"svgatest","48 flagtest：${flagtest}")
                                    this.listScroller.scrollToIndex(14)
                            }
                             }
                        }
                            ListItem() {
                    Column(5) {
                        Button('49-1.设置播放次数setLoops-loops设置正数')
                            .id("EntryView71")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 49
                            }
                        Button('49-2.设置播放次数setLoops-loops设置正数')
                            .id("EntryView72")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller49.setLoops(3)
                                    controller49.load("angel.svga", autoPlay: true)
                                    flagtest = true
                                    //效果为播放3次后停止
                                    Hilog.error(0,"svgatest","49 flagtest：${flagtest}")
                            }
                        Button('50-1.设置播放速度setCurRate-curRate设置负数')
                            .id("EntryView73")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 50
                            }
                        Button('50-2.设置播放速度setCurRate-curRate设置负数')
                            .id("EntryView74")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    // 不保证效果。合理使用范围需要大于0
                                    controller50.setCurRate(-10.0)
                                    controller50.load("angel.svga", autoPlay: true)
                                    flagtest = true
                                    Hilog.error(0,"svgatest","50 flagtest：${flagtest}")
                            }
                        Button('51-1.设置播放速度setCurRate-curRate设置0')
                            .id("EntryView75")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 51
                                    this.listScroller.scrollToIndex(15)
                            }
                             }
                        }
                            ListItem() {
                    Column(5) {
                        Button('51-2.设置播放速度setCurRate-curRate设置0')
                            .id("EntryView76")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller51.setCurRate(0.0)
                                    controller51.load("angel.svga", autoPlay: true)
                                    flagtest = true
                                     // 效果同arkts对标库，效果为播放很慢
                                    Hilog.error(0,"svgatest","51 flagtest：${flagtest}")
                            }
                        Button('52-1.设置播放速度setCurRate-curRate设置正数')
                            .id("EntryView77")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 52
                            }
                        Button('52-2.设置播放速度setCurRate-curRate设置正数')
                            .id("EntryView78")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller52.setCurRate(3.0)
                                    controller52.load("angel.svga", autoPlay: true)
                                    flagtest = true
                                    // 效果为播放很快
                                    Hilog.error(0,"svgatest","52 flagtest：${flagtest}")
                            }
                        Button('53-1.setText')
                            .id("EntryView79")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                flagtest = false
                                buttonIndex = 53
                            }
                        Button('53-2.setText')
                            .id("EntryView80")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                 var textConfig: TextMap = TextMap()
                                 let offset: TextOffset = TextOffset()
                                 offset.x=100.0
                                 offset.y=0.0
                                 textConfig.text = "w 我！@#&*%）*-"
                                 textConfig.size = 20.0
                                 textConfig.color = Color(0xFF0000)
                                 textConfig.offset = offset
                                 textConfig.family = 'Arial'
                                 textConfig.weight = FontWeight.Bold
                                flagtest = true
                                controller53.setText(textConfig, 'banner');
                                Hilog.error(0,"svgatest","53 flagtest：${flagtest}")
                                this.listScroller.scrollToIndex(16)
                            }
                             }
                        }
                            ListItem() {
                    Column(5) {
                        Button('54-1.setImage-传入ImageSource')
                            .id("EntryView81")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 54
                            }
                        Button('54-2.setImage-传入ImageSource')
                            .id("EntryView82")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    let sourceOptions: SourceOptions = SourceOptions(sourceDensity: 120)
                                    var path = "/data/storage/el1/bundle/entry/resources/resfile/startIcon.png"
                                    let imageSource: ImageSource = createImageSource(path, sourceOptions)
                                    controller54.setImage(imageSource, '99', transform: Option<Transform>.None)
                                    flagtest = true
                                    // 效果为动画中图片被替换
                                     Hilog.error(0,"svgatest","54 flagtest：${flagtest}")
                            }
                        Button('55-1.setImage-传入String')
                            .id("EntryView83")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 55
                            }
                        Button('55-2.setImage-传入String')
                            .id("EntryView84")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller55.setImage(
                                        "/data/storage/el1/bundle/entry/resources/resfile/startIcon.png", '99',
                                        transform: Option<Transform>.None)
                                    flagtest = true
                                    // 效果为动画中图片被替换
                                    Hilog.error(0,"svgatest","55 flagtest：${flagtest}")
                            }
                        Button('56-1.onFinished')
                            .id("EntryView85")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 56
                                    this.listScroller.scrollToIndex(17)
                            }
                        }
                        }
                            ListItem() {
                    Column(5) {
                        Button('56-2.onFinished')
                            .id("EntryView86")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller56.onFinished(onFinishedCallback)
                                    controller56.load("angel.svga", autoPlay: true)
                                    flagtest = true
                                     Hilog.error(0,"svgatest","56 flagtest：${flagtest}")
                            }
                        Button('57-1.onFrame')
                            .id("EntryView87")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 57
                            }
                        Button('57-2.onFrame')
                            .id("EntryView88")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller57.onFrame(onFrameCallback)
                                    controller57.load("angel.svga", autoPlay: true)
                                    flagtest = true
                                     Hilog.error(0,"svgatest","57 flagtest：${flagtest}")
                            }
                        Button('58-1.onPercentage')
                            .id("EntryView89")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    flagtest = false
                                    buttonIndex = 58
                            }
                        Button('58-2.onPercentage')
                            .id("EntryView90")
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                    controller58.onPercentage(onPercentageCallback)
                                    controller58.load("angel.svga", autoPlay: true)
                                    controller58.release()
                                    flagtest = true
                                     Hilog.error(0,"svgatest","58 flagtest：${flagtest}")
                            }
                    }
                }
            }
                .width(100.percent)
                .height(30.percent)
                .scrollBar(BarState.Off)
                .alignListItem(ListItemAlign.Center)
        }
            .width(100.percent)
            .height(100.percent)
    }
}
