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
import org.unq.epers.grupo5.rentauto.exceptions.LoginIncorrectoException
import org.unq.epers.grupo5.rentauto.exceptions.EntidadNoExisteException
import org.unq.epers.grupo5.rentauto.exceptions.NuevaPasswordInvalidaException

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
	
	@Test(expected = LoginIncorrectoException)
	def void testLoginIncorrectoPorContrasenia(){
		var Usuario miguel
		sistema.registrar(miguelDelSel)
		miguel = sistema.login("miguelds","dameDameDameTodoElPower")
	}
	
	@Test(expected = EntidadNoExisteException)
	def void testLoginIncorrectoPorExistencia(){
		var Usuario miguel
		sistema.registrar(miguelDelSel)
		miguel = sistema.login("miguel","dameLaPresidencia")
	}
	
	def void testLoginCorrecto(){
		var Usuario miguel
		sistema.registrar(miguelDelSel)
		miguel = sistema.login("miguelds","dameLaPresidencia")
		assertTrue(miguel == miguelDelSel)
	}
	
	def void testValidarCuentaActualizaAlUsuarioDejandoloValidadoSiElCodigoValidacionEsCorrecto()
	{
		sistema.validarCuenta(miguelDelSel ,  "1234567890")
		assertTrue(miguelDelSel.isIs_validado)
	}
	
	@Test(expected = NuevaPasswordInvalidaException)
	def void cambiarPasswordInvalido(){
		sistema.cambiarPassword(miguelDelSel, "dameLaPresidencia")
	}
	
	def void cambiarPassword(){
		sistema.cambiarPassword(miguelDelSel, "dameDameDameTodoElPower")
		assertTrue(miguelDelSel.password == "dameDameDameTodoElPower")
	}
	

	def dropAndCreateDatabase() {
		val schemaDdlCommands = new String(Files.readAllBytes(Paths.get(SCHEMA_PATH))).split(";").filter[it != "\n" && it != "\r"]
		schemaDdlCommands.forEach [ executeCommand(it) ]
	}	

}

