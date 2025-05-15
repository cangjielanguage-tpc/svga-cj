// DEPENDENCE: zlib_01_test.md
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import zlib4cj.*

import std.process.*
import std.fs.*
import std.time.*
import std.collection.ArrayList

func runBench():Unit{
    var path: String = Process.current.workingDirectory.toString()
    var fileName: String = "${path}/zlib_01_test.md"
    var data: Array<UInt8> = Array<UInt8>()

    data = File.readFrom(fileName)
    let compressAfterData_9 = Zlib.compress(data, level: UInt32(9), wrap: ZLIB)
    let arr_9 = Array<UInt8>(compressAfterData_9.size, { i => compressAfterData_9[i]})

    let compressAfterData_1 = Zlib.compress(data, level: UInt32(0), wrap: ZLIB)
    let arr_1 = Array<UInt8>(compressAfterData_1.size, { i => compressAfterData_1[i]})

    var n = 10000
	var s = MonoTime.now()
	for (i in 0..n){
		Zlib.uncompress(arr_1, wrap: ZLIB)
	}
	var e = MonoTime.now()
    var temp = (e-s).toNanoseconds()
    print("[ PASSED ] CASE: zlib_uncompress_10K_level0_${n} (${temp} ns, ${Float64(temp)/Float64(n)} ns/op)\n", flush:true)

    var s1 = MonoTime.now()
	for (i in 0..n){   
		Zlib.uncompress(arr_9, wrap: ZLIB)
	}
	var e1 = MonoTime.now()
    temp = (e1-s1).toNanoseconds()
    print("[ PASSED ] CASE: zlib_uncompress_10K_level9_${n} (${temp} ns, ${Float64(temp)/Float64(n)} ns/op)\n", flush:true)
 
}

main(){
	println("TCS: zlib_uncompress, time elapsed: 1 ns, RESULT:")
    runBench()
}