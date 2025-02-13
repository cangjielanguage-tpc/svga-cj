import { CJHybridComponentV2 } from 'cjhybridview'

@Entry
@Component
struct TestPage2 {
  @State message: string = 'Hello World';

  build() {
    Column() {
      CJHybridComponentV2({
        library: 'ohos_app_cangjie_entry',
        component: 'TestPage2'
      })
    }
    .height('100%')
    .width('100%')
  }
}