package org.unq.epers.grupo5.rentauto

import org.junit.Test
import static org.unq.epers.grupo5.rentauto.extensions.DateExtensions.*
import static org.junit.Assert.*
import org.unq.epers.grupo5.rentauto.model.ReservaException
import org.unq.epers.grupo5.rentauto.model.ReservaEmpresarial

class EmpresaTest extends AbstractTest{
	@Test
	def void reservaOk(){
		new ReservaEmpresarial => [
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
		new ReservaEmpresarial => [
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