import XCTest
@testable import AllSubsets

class AllSubsetsTests: XCTestCase {
    func testAllSubsets() {
      let input = 3

      let subsetConstructor = SubsetConstructor(for: input)

      let output: Set<Set<Int>> = [[], [1], [1, 2], [2], [2, 3], [1, 2, 3], [1, 3], [3]]

      XCTAssertEqual(subsetConstructor.build(), output)
    }
}

// START - k = 0,
//         a = [false, false, false]
//         solutions = []

// BTRACK-1 - k = 0 / a = [false, false, false] / solutions = []
//    FOR i in 0...1
//      i = 0/TRUE
//      BTRACK-1.1 - k = 1 / a = [true, false, false] / sol's = []
    //    FOR i in 0...1
    //      i = 0/TRUE
//          BTRACK-1.1.1 - k = 2 / a = [true, true, false] / sol's = []
 //           FOR i in 0...1
 //            i = 0/TRUE
 //            BTRACK-1.1.1.1 - k = 3 / a = [true, true, true] / sol's = []
 //              k == 3 -> RETURNS (new sol = [1 2 3])
 //            i = 1/FALSE
 //            BTRACK-1.1.1.2 - k = 3 / a = [true, true, FALSE] / sol's = [[1 2 3]]
 //              k == 3 -> RETURNS (new sol = [1 2])
 //           ENDFOR (1.1.1)
//          i = 1/FALSE
//          BTRACK-1.1.2 - k = 2 / a = [true, FALSE, FALSE] / sol's = [[1 2 3], [1 2]]
//            FOR i in 0...1
//             i = 0/TRUE (a[k+1] = true)
//             BTRACK-1.1.2.1 - k = 3 / a = [true, FALSE, true] / sol's = [[1 2 3], [1 2]]
//               k == 3 -> RETURNS (new sol = [1 3])
//             i = 1/FALSE (a[k+1] = false
//             BTRACK -1.1.2.2 - k = 3 / a = [true, FALSE, FALSE] / sol's = [[1 2 3], [1 2], [1 3]]
//               k == 3 -> RETURNS (new sol = [1])
//            ENDFOR (1.1.2)
//        ENDFOR (1.1)
//      i = 1/FALSE (a[1] = false)
//      BTRACK-1.2 - k = 1 / a = [FALSE, FALSE, FALSE] / sol's = [[1 2 3], [1 2], [1 3], [1]
//        FOR i in 0...1
//         i = 0/TRUE (a[2] = true)
//         BTRACK-1.2.1 - k = 2 / a = [FALSE, true, FALSE] / sol's = [[1 2 3], [1 2], [1 3], [1]
//          FOR i in 0...1
//            i = 0/TRUE (a[3] = true)
//            BTRACK-1.2.1.1 - k = 3 / a = [FALSE, true, true] / sol's = [[1 2 3], [1 2], [1 3], [1]
//              k == 3 -> RETURNS (new sol = [2 3])
//            i = 1/FALSE (a[3] = FALSE)
//            BTRACK-1.2.1.1 - k = 3 / a = [FALSE, true, FALSE] / sol's = [[1 2 3], [1 2], [1 3], [1], [2 3]]
//              k == 3 -> RETURNS (new sol = [2])
//          ENDFOR (1.2.1)
//         i = 1/FALSE (a[2] = FALSE)
//         BTRACK-1.2.2 - k = 2 / a = [FALSE, FALSE, FALSE] / sol's = [[1 2 3], [1 2], [1 3], [1], [2 3], [2]]
//           FOR i in 0...1
  //           i = 0/TRUE (a[3] = true)
  //           BTRACK-1.2.2.1 - k = 3 / a = [FALSE, FALSE, true] / sol's = [[1 2 3], [1 2], [1 3], [1], [2 3], [2]]
  //             k == 3 -> RETURNS (new sol = [3])
  //           i = 1/FALSE (a[3] = FALSE)
  //           BTRACK-1.2.2.1 - k = 3 / a = [FALSE, FALSE, FALSE] / sol's = [[1 2 3], [1 2], [1 3], [1], [2 3], [2], [3]
  //             k == 3 -> RETURNS (new sol = [])
//           ENDFOR (1.2.2)
//        ENDFOR (1.2)
//    ENDFOR (1)
// FINAL SOLUTION - [[1 2 3], [1 2], [1 3], [1], [2 3], [2], [3], []]
