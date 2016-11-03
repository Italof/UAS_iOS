//
//  citaClass.swift
//  UASapp
//
//  Created by inf227al on 3/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

class cita{
    
    
    
    var idDocente: String?
    var idEspecialidad: String?
    var codigo: String?
    var nombre: String?
    var apellidoPaterno: String?
    var apellidoMaterno: String?
    var correo: String?
    var oficina: String?
    var telefono: String?
    var anexo: String?
    var horarioL:String?
    var horarioMa:String?
    var horarioMi:String?
    var horarioJ:String?
    var horarioV:String?
    
    //var schedules: [schedule]
    
    
    
    init(idDocente: String?,idEspecialidad: String?, codigo: String?, nombre: String?, apellidoPaterno: String?,apellidoMaterno: String?, correo: String?, oficina: String?, telefono: String?, anexo: String?, horarioL: String?, horarioMa: String?, horarioMi: String?, horarioJ: String?, horarioV: String?){
        self.idDocente = idDocente
        self.idEspecialidad=idEspecialidad
        self.codigo=codigo
        self.nombre=nombre
        self.apellidoPaterno=apellidoPaterno
        self.apellidoMaterno=apellidoMaterno
        self.correo=correo
        self.oficina=oficina
        self.telefono=telefono
        self.anexo=anexo
        self.horarioL=horarioL
        self.horarioMa=horarioMa
        self.horarioMi=horarioMi
        self.horarioJ=horarioJ
        self.horarioV=horarioV
    }
    
}
