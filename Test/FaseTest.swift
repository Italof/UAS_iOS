//
//  FaseTest.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 3/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import XCTest
@testable import UASapp
class FaseTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFaseId() {
        let fase = Fases(idPhase: 1)
        XCTAssertEqual(String(fase.idPhase), "1", "Id establecido")
    }
    
    func testDescripcion() {
        let fase = Fases(descripcion:"Fase",idPhase: 1)
        XCTAssertEqual(fase.descripcion, "Fase", "Id establecido")
    }
    
    func testFaseNumero() {
        let fase = Fases(idPhase: 1,numero:"1")
        XCTAssertEqual(fase.numero, "1", "Id establecido")
    }
    
    func testFaseFechaInicio() {
        let fase = Fases(fecha_inicio:"22/08/2016",idPhase: 1)
        XCTAssertEqual(fase.fecha_inicio, "22/08/2016", "Id establecido")
    }
    
    func testFaseFechaFin() {
        let fase = Fases(fecha_fin:"22/08/2016",idPhase: 1)
        XCTAssertEqual(fase.fecha_fin, "22/08/2016", "Id establecido")
    }
    
}
