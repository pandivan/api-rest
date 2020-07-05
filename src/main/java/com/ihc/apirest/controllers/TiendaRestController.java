package com.ihc.apirest.controllers;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.ihc.apirest.models.Tienda;
import com.ihc.apirest.repository.TiendaRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;



@RestController
@RequestMapping("/api")
public class TiendaRestController 
{
    @Autowired
    TiendaRepository tiendaRepository;


    /**
     * Método que permite crear una nueva tienda en BD
     * @param tienda, Tienda a crear
     * @return Tienda creada
     */
    @PostMapping(value="/tienda")
    public ResponseEntity<Boolean> crearTienda(@RequestBody Tienda tienda)
    {
        try 
        {
            Long idTiempoFechaCreacion = Long.parseLong(new SimpleDateFormat("yyyyMMdd").format(new Date()));
            
            tienda.setIdTiempoFechaCreacion(idTiempoFechaCreacion);

            //Este metodo creará una tienda en BD
            tiendaRepository.save(tienda);

            return new ResponseEntity<Boolean>(true, HttpStatus.CREATED);
		} 
        catch (Exception e) 
        {
            return new ResponseEntity<Boolean>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
     }


     /**
     * Método que permite actualizar una tienda en BD
     * @param tienda, Tienda actualizar
     * @return Tienda actualizada
     */
    @PutMapping("/tienda")
    public ResponseEntity<Boolean> actualizarTienda(@RequestBody Tienda tienda)
    {
        try 
        {
            //Este metodo creará un usuario en BD
            tiendaRepository.save(tienda);
            
            return new ResponseEntity<Boolean>(true, HttpStatus.CREATED);
		} 
        catch (Exception e) 
        {
            return new ResponseEntity<Boolean>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
     }
	
    
    /**
     * Método que permite obtener un tienda según el nit
     * @param nit, Nit con el cual se buscara la tienda en BD
     * @return Tienda encontrada
     */
    @GetMapping(value = "/tienda/{nit}")
    public ResponseEntity<Tienda> findByNit(@PathVariable String nit) 
    {
        try
        {
            Tienda tienda = tiendaRepository.findByNit(nit);
            
            return new ResponseEntity<Tienda>(tienda, HttpStatus.OK);
        }
        catch (Exception e) 
        {
			return new ResponseEntity<Tienda>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}