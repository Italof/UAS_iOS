//
//  GradeCriterio.swift
//  UASapp
//
//  Created by inf227al on 21/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

struct GradeCriterio {
    //Estructura para un estudiante del UAS
    //modelo
    var id: Int
    var idCriterio: Int
    var idAlumno: Int
    var grade: Int
    var criterio: String?
    var idAspecto: Int
    //funcion inicializadora
    init(id:Int, idCriterio: Int, idAlumno: Int, grade: Int, criterio: String?, idAspecto: Int){
        self.id = id
        self.idCriterio = idCriterio
        self.idAlumno = idAlumno
        self.grade = grade
        self.criterio = criterio
        self.idAspecto = idAspecto
    }
}
