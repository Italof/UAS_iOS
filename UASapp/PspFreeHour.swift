//
//  PspFreeHour.swift
//  UASapp
//
//  Created by Luis Salas Rodriguez on 10/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import Foundation

class PspFreeHour{
    
var cantidad:Int;
var fecha:String;
var hora_ini:Int;
var id:Int;
var idsupervisor:Int;
var created_at: String?
var updated_at: String?
var deleted_at: String?
var idpspprocess: String?
    
    
    init(cantidad:Int,fecha:String,hora_ini:Int,id:Int,idsupervisor:Int,idpspprocess: String?,created_at:String?,updated_at:String?,deleted_at:String?){
        
        self.cantidad = cantidad;
        self.fecha = fecha;
        self.hora_ini = hora_ini;
        self.id = id;
        self.idsupervisor = idsupervisor;
        self.idpspprocess = idpspprocess
        self.created_at = created_at
        self.updated_at = updated_at
        self.deleted_at = deleted_at
    
}

}
