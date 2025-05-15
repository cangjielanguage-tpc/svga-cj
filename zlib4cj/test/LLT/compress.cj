// DEPENDENCE: zlib_01_test.md
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import zlib4cj.*

import std.process.*
import std.fs.*
import std.time.*
import std.collection.ArrayList

func runBench(l:UInt32):Unit{
    var path: String = Process.current.workingDirectory.toString()
    var fileName: String = "${path}/zlib_01_test.md"
    var data: Array<UInt8> = Array<UInt8>()
    data = File.readFrom(fileName)

    let n = 10000
	let s = MonoTime.now()
	for (i in 0..n){
		Zlib.compress(data, level: l, wrap: ZLIB)
	}
	let e = MonoTime.now()
    let temp = (e-s).toNanoseconds()
	print("[ PASSED ] CASE: zlib_compress_10K_level${l}_${n} (${temp} ns, ${Float64(temp)/Float64(n)} ns/op)\n", flush:true)

}

main(){
	println("TCS: zlib_compress, time elapsed: 1 ns, RESULT:")
	let levels = [UInt32(0),UInt32(9)]
	for (l in levels){
        runBench(l)
	}
}