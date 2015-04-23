package org.unq.epers.grupo5.rentauto

import org.junit.Test

import static org.junit.Assert.*

class CalculoDePrecioTest extends AbstractTest {
		
	@Test
	def precioFamiliar(){
		assertEquals(auto.costoTotal, auto.costoBase+200, 0)
	}
	
	@Test
	def precioTodoTerreno(){
		auto.categoria = new ar.edu.unq.epers.model.TodoTerreno
		assertEquals(auto.costoTotal, auto.costoBase*1.10, 0)
	}
	
	@Test
	def precioDeportivo(){
		auto.categoria = new ar.edu.unq.epers.model.Deportivo
		assertEquals(auto.costoTotal, auto.costoBase*1.20, 0)
	}
	
	@Test
	def precioTurismo(){
		auto.categoria = new ar.edu.unq.epers.model.Turismo
		assertEquals(auto.costoTotal, auto.costoBase - 200, 0)
	}
	
}