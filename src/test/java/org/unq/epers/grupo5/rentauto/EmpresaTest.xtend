package org.unq.epers.grupo5.rentauto

import org.junit.Test
import static ar.edu.unq.epers.extensions.DateExtensions.*
import static org.junit.Assert.*
import ar.edu.unq.epers.model.ReservaException

class EmpresaTest extends AbstractTest{
	@Test
	def void reservaOk(){
		new ar.edu.unq.epers.model.ReservaEmpresarial => [
			origen = retiro
			destino = aeroparque
			inicio = nuevaFecha(2015,03,01)
			fin = nuevaFecha(2015,03,05)
			it.auto = this.auto
			it.usuario = usuarioEmpresa
			it.empresa = empresa 
			reservar()
		]
		assertEquals(1, empresa.reservas.size)
	}

	@Test(expected=ReservaException)
	def void reservaUsuarioInvalido(){
		new ar.edu.unq.epers.model.ReservaEmpresarial => [
			origen = retiro
			destino = aeroparque
			inicio = nuevaFecha(2015,03,01)
			fin = nuevaFecha(2015,03,05)
			it.auto = this.auto
			it.usuario = usuarioPrueba
			it.empresa = empresa 
			reservar()
		]
		fail()
	}

}