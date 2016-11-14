//
//  PspInscription.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 11/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

class PspInscription{
    
    var Correo_jefe_directo:String
    var activ_formativas:String
    var actividad_economica:String
    var cond_seguridad_area:String
    var direccion_empresa:String
    var distrito_empresa:String
    var equi_del_practicante:String
    var equipamiento_area:String
    var fecha_inicio:String
    var fecha_recep_convenio:String
    var fecha_termino:String
    var id:Int
    var jefe_directo_aux:String
    var nombre_area:String
    var personal_area:String
    var puesto:String
    var razon_social:String
    var recomendaciones:String
    var telef_jefe_directo:String
    var tiene_convenio:Int
    var ubicacion_area:String
    var created_at:String?
    var updated_at:String?
    var deleted_at:String?
    
    
    init(Correo_jefe_directo:String,activ_formativas:String,actividad_economica:String,cond_seguridad_area:String,direccion_empresa:String,distrito_empresa:String,equi_del_practicante:String,equipamiento_area:String,fecha_inicio:String,fecha_recep_convenio:String,fecha_termino:String,id:Int,jefe_directo_aux:String,nombre_area:String,personal_area:String,puesto:String,razon_social:String,recomendaciones:String,telef_jefe_directo:String,tiene_convenio:Int,ubicacion_area:String,created_at:String?,updated_at:String?,deleted_at:String?){

        self.Correo_jefe_directo=Correo_jefe_directo
        self.activ_formativas=activ_formativas
        self.actividad_economica=actividad_economica
        self.cond_seguridad_area=cond_seguridad_area
        self.direccion_empresa=direccion_empresa
        self.distrito_empresa=distrito_empresa
        self.equi_del_practicante=equi_del_practicante
        self.equipamiento_area=equipamiento_area
        self.fecha_inicio=fecha_inicio
        self.fecha_recep_convenio=fecha_recep_convenio
        self.fecha_termino=fecha_termino
        self.id=id
        self.jefe_directo_aux=jefe_directo_aux
        self.nombre_area=nombre_area
        self.personal_area=personal_area
        self.puesto=puesto
        self.razon_social=razon_social
        self.recomendaciones=recomendaciones
        self.telef_jefe_directo=telef_jefe_directo
        self.tiene_convenio=tiene_convenio
        self.ubicacion_area=ubicacion_area
        self.created_at=created_at
        self.updated_at=updated_at
        self.deleted_at=deleted_at
        
    }
    
}
