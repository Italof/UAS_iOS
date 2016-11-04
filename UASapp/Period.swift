//
//  Period.swift
//  UASapp
//
//  Created by inf227al on 2/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

struct Period {
    //Estructura para un periodo del UAS
    //modelo
    var id: Int
    var idEspecialidad: String?
    var vigente: String?
    var cycleStart: String?
    var cycleEnd: String?
    var aceptacion: String?
    var nivEsperado: String?
    var nivCriterio: String?
    //funcion inicializadora
    init(id:Int, idEspecialidad:String?, vigente:String?, cycleStart:String?, cycleEnd: String?, aceptacion: String?,nivEsperado:String?,nivCriterio:String?){
        self.id = id
        self.idEspecialidad = idEspecialidad
        self.vigente = vigente
        self.cycleStart = cycleStart
        self.cycleEnd = cycleEnd
        self.aceptacion=aceptacion
        self.nivEsperado=nivEsperado
        self.nivCriterio=nivCriterio
    }
    
}
