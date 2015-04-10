package org.unq.epers.grupo5.rentauto

import java.sql.Date
import org.junit.Before
import org.junit.Test
import org.unq.epers.grupo5.rentauto.entities.Usuario
import org.unq.epers.grupo5.rentauto.persistence.UsuarioHome

import static org.junit.Assert.*
import java.nio.file.Files
import java.nio.file.Paths
import org.unq.epers.grupo5.rentauto.exceptions.UsuarioYaExisteException

class SistemaTest extends DatabaseTest {
	
	static val SCHEMA_PATH = "src/main/resources/tp1.sql"
	
	var Sistema sistema 
	var Usuario miguelDelSel
	
	@Before 
	def void setUp()
	{
		dropAndCreateDatabase
		
		sistema = new Sistema() 
		miguelDelSel = new Usuario() => [
			id = 1
			nombre = "Miguel"
			apellido = "Del Sel"
			username = "miguelds"
			password = "dameLaPresidencia"
			email = "miguelds@pro.gov.ar"
			nacimiento = new Date(1957,7,3)
			codigo_validacion = "1234567890"
		]

	}
	
	@Test
	def void testSiRegistroUnNuevoUsuarioPuedoEncontrarloPorSuUsername()
	{
		val home = new UsuarioHome()
		sistema.registrar(miguelDelSel)
		assertEquals(miguelDelSel.id, home.findByUsername(miguelDelSel.username).id)
	}
	
	@Test(expected = UsuarioYaExisteException)
	def void testNoSePuedeRegistrarElMismoUsuarioDosVeces()
	{
		val home = new UsuarioHome()
		sistema.registrar(miguelDelSel)
		sistema.registrar(miguelDelSel)
	}
	
	@Test
	def void testValidarCuentaActualizaAlUsuarioDejandoloValidadoSiElCodigoValidacionEsCorrecto()
	{
		sistema.validarCuenta(miguelDelSel ,  "1234567890")
		assertTrue(miguelDelSel.isIs_validado)
	}
	

	def dropAndCreateDatabase() {
		val schemaDdlCommands = new String(Files.readAllBytes(Paths.get(SCHEMA_PATH))).split(";").filter[it != "\n" && it != "\r"]
		schemaDdlCommands.forEach [ executeCommand(it) ]
	}	

}

