package org.unq.epers.grupo5.rentauto.entities

import java.sql.Date
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.unq.epers.grupo5.rentauto.model.IUsuario
import org.unq.epers.grupo5.rentauto.model.Reserva

@Accessors 
class Usuario extends Entity implements IUsuario {
	var String nombre
	var String apellido
	var String username
	var String password
	var String email
	var Date nacimiento
	var String codigo_validacion
	var boolean is_validado
	
	List<Reserva> reservas = new ArrayList<Reserva>
	
	override agregarReserva(Reserva unaReserva) {
		reservas.add(unaReserva)
	}
	
	override getReservas() {
		reservas
	}
	
}