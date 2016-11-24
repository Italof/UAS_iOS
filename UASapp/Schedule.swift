//
//  Schedule.swift
//  UASapp
//
//  Created by inf227al on 5/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

struct Schedule {
    //Estructura para un horario de un curso que dicta un profesor del UAS
    //modelo
    var id: Int
    var code: String?
    var idEspecialidad: String?
    var course: String?
    var codeCourse: String?
    var idProfesor: String?
    var nivAcademico: String?
    var nameProf: String?
    var idCurso: Int?
    var evidences: [Evidence] = []
    
    //funcion inicializadora
    init(id:Int, code:String?,idEspecialidad:String?, course:String?,codeCourse:String?, idProfesor:String?, nivAcademico: String?, idCurso: Int, evidences: [Evidence]){
        self.id = id
        self.code = code
        self.idEspecialidad = idEspecialidad
        self.course = course
        self.codeCourse = codeCourse
        self.idProfesor = idProfesor
        self.nivAcademico = nivAcademico
        self.idCurso = idCurso
        self.evidences = evidences
    }
    
    init(id:Int,code:String?, nameProf: String?, codeCourse: String?, nameCourse: String?, evidences: [Evidence]){
        self.id=id
        self.code = code
        self.nameProf = nameProf
        self.codeCourse = codeCourse
        self.course = nameCourse
        self.evidences = evidences
    }
    
}
