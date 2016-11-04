//
//  tutorClass.swift
//  UASapp
//
//  Created by inf227al on 28/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

class tutor{
    
    
    
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
    
    init(idDocente: String?, codigo: String?, nombre: String?, apellidoPaterno: String?, apellidoMaterno: String?){
        self.idDocente = idDocente
        self.codigo = codigo
        self.nombre = nombre
        self.apellidoPaterno = apellidoPaterno
        self.apellidoMaterno = apellidoMaterno
    }
    
}
/*
class schedule{
    var dia: Int
    var horaInicio: String?
    var horaFin: String?
    
    init (dia: Int,hora_inicio: String?, hora_fin: String?){
        self.dia=dia
        self.horaInicio=hora_inicio
        self.horaFin=hora_fin
    }
 
    
}
 */
