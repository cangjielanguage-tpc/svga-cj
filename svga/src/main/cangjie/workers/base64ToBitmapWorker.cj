/**
 * Created on 2025/1/17
 */
package svga.workers

//var workerPort: ThreadWorkerGlobalScope = worker.workerPort;
///**
// * Defines the event handler to be called when the worker thread receives a message sent by the host thread.
// * The event handler is executed in the worker thread.
// *
// * @param e message data
// */
//
//func workerPort(data: Array<Byte>) {
//
//}
//workerPort.onmessage = (e: MessageEvents) => {
//  const src: string = e.data.src
//  const key: string = e.data.key
//  const type: 'img' | 'audio' = e.data.type
//  const dir: string = e.data.dir || ''
//  try {
//    if (type === 'img') {
//      const base = new util.Base64Helper()
//      let buf = base.decodeSync(src)
//      // 1, 创建imageSource
//      const img = image.createImageSource(buf.buffer)
//      const info = img.getImageInfoSync()
//      let pixelMap: image.PixelMap | null = null
//      if (img) {
//        pixelMap = img.createPixelMapSync({
//          editable: false, desiredSize: {
//            width: info.size.width,
//            height: info.size.height
//          }
//        })
//        img.release()
//        const bitmap = new ImageBitmap(pixelMap!, LengthMetricsUnit.PX)
//        pixelMap?.release()
//        pixelMap = null
//        workerPort.postMessage({
//          key,
//          bitmap,
//        })
//      } else {
//        workerPort.postMessage({
//          key,
//          bitmap: null,
//        })
//      }
//    } else {
//      const fd = FileManager.saveAudio(src, dir)
//      workerPort.postMessage({
//        key,
//        fd
//      })
//
//    }
//  } catch (e) {
//    workerPort.postMessage({
//      key,
//      bitmap: null,
//    })
//
//  }
//
//}
//
///**
// * Defines the event handler to be called when the worker receives a message that cannot be deserialized.
// * The event handler is executed in the worker thread.
// *
// * @param e message data
// */
//workerPort.onmessageerror = (_: MessageEvents) => {
//}
//
///**
// * Defines the event handler to be called when an exception occurs during worker execution.
// * The event handler is executed in the worker thread.
// *
// * @param e error message
// */
//workerPort.onerror = (_: ErrorEvent) => {
//}