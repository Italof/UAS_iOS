//
//  PspDocuments.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 11/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation
class PspDocuments {
    
    var created_at:String?
    var deleted_at:String?
    var es_fisico:Int?
    var es_obligatorio:String
    var fecha_limite:String
    var id:Int
    var idstudent:Int
    var idtemplate:Int
    var idtipoestado:Int
    var numerofase:Int?
    var observaciones:String
    var ruta:String
    var ruta_plantilla:String?
    var titulo_plantilla:String?
    var updated_at:String?
    
    init(es_fisico:Int?,es_obligatorio:String,fecha_limite:String,id:Int,idstudent:Int,idtemplate:Int,idtipoestado:Int,numerofase:Int?,observaciones:String,ruta:String,ruta_plantilla:String?,titulo_plantilla:String?,created_at:String?,deleted_at:String?,updated_at:String?) {

       self.created_at = created_at
        self.es_fisico = es_fisico
        self.es_obligatorio = es_obligatorio
        self.fecha_limite = fecha_limite
        self.id = id
        self.idstudent = idstudent
        self.idtemplate = idtemplate
        self.idtipoestado = idtipoestado
        self.numerofase = numerofase
        self.observaciones = observaciones
        self.ruta = ruta
        self.ruta_plantilla = ruta_plantilla
        self.titulo_plantilla = titulo_plantilla
        self.updated_at = updated_at
        self.created_at = created_at
        self.deleted_at = deleted_at
    }
    
}
