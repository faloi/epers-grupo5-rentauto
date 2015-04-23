package org.unq.epers.grupo5.rentauto

import org.junit.Test

import static org.junit.Assert.*
import static ar.edu.unq.epers.extensions.DateExtensions.*
import ar.edu.unq.epers.model.ReservaException

class ValidarReservasTest extends AbstractTest {
	@Test
	def reservaUnica() {
		new ar.edu.unq.epers.model.Reserva => [
			origen = retiro
			destino = aeroparque
			inicio = nuevaFecha(2015, 03, 01)
			fin = nuevaFecha(2015, 03, 05)
			it.auto = this.auto
			it.usuario = usuarioPrueba
			reservar()
		]
		assertEquals(1, auto.reservas.size)
	}

	@Test
	def reservaQueNoSePisan() {
		new ar.edu.unq.epers.model.Reserva => [
			origen = retiro
			destino = aeroparque
			inicio = nuevaFecha(2015, 03, 01)
			fin = nuevaFecha(2015, 03, 05)
			it.auto = this.auto
			it.usuario = usuarioPrueba
			reservar()
		]

		new ar.edu.unq.epers.model.Reserva => [
			origen = aeroparque
			destino = retiro
			inicio = nuevaFecha(2015, 03, 06)
			fin = nuevaFecha(2015, 03, 07)
			it.auto = this.auto
			it.usuario = usuarioPrueba
			reservar()
		]

		assertEquals(2, auto.reservas.size)
	}

	@Test(expected=ReservaException)
	def reservaQueSePisan() {
		auto.agregarReserva(
			new ar.edu.unq.epers.model.Reserva => [
				origen = retiro
				destino = aeroparque
				inicio = nuevaFecha(2015, 03, 01)
				fin = nuevaFecha(2015, 03, 05)
				it.auto = this.auto
			])

		auto.agregarReserva(
			new ar.edu.unq.epers.model.Reserva => [
				origen = aeroparque
				destino = retiro
				inicio = nuevaFecha(2015, 03, 04)
				fin = nuevaFecha(2015, 03, 07)
				it.auto = this.auto
			])

		fail()
	}

	@Test(expected=ReservaException)
	def reservasSinSentido() {
		auto.agregarReserva(
			new ar.edu.unq.epers.model.Reserva => [
				origen = retiro
				destino = aeroparque
				inicio = nuevaFecha(2015, 03, 01)
				fin = nuevaFecha(2015, 03, 05)
				it.auto = this.auto
			])

		auto.agregarReserva(
			new ar.edu.unq.epers.model.Reserva => [
				origen = retiro
				destino = aeroparque
				inicio = nuevaFecha(2015, 03, 05)
				fin = nuevaFecha(2015, 03, 07)
				it.auto = this.auto
			])

		fail()
	}

}
