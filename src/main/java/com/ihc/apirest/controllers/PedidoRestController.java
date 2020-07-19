package com.ihc.apirest.controllers;

import com.ihc.apirest.models.Pedido;
import com.ihc.apirest.models.Venta;
import com.ihc.apirest.repository.PedidoRepository;

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
public class PedidoRestController 
{
    @Autowired
    PedidoRepository pedidoRepository;


    /**
     * Método que permite crear una nueva pedido en BD
     * @param pedido, Pedido a crear
     * @return Pedido creada
     */
    @PostMapping(value="/pedido")
    public ResponseEntity<Boolean> crearPedido(@RequestBody Pedido pedido)
    {
        try 
        {
            for (Venta venta : pedido.getLstVentas()) 
            {
                venta.setPedido(pedido);    
            }

            //Este metodo creará una pedido en BD
            pedidoRepository.save(pedido);

            return new ResponseEntity<Boolean>(true, HttpStatus.CREATED);
		} 
        catch (Exception e) 
        {
            return new ResponseEntity<Boolean>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
     }


     /**
     * Método que permite actualizar una pedido en BD
     * @param pedido, Pedido actualizar
     * @return Pedido actualizada
     */
    @PutMapping("/pedido")
    public ResponseEntity<Boolean> actualizarPedido(@RequestBody Pedido pedido)
    {
        try 
        {
            //Este metodo creará un usuario en BD.
            pedidoRepository.save(pedido);
            
            return new ResponseEntity<Boolean>(true, HttpStatus.CREATED);
		} 
        catch (Exception e) 
        {
            return new ResponseEntity<Boolean>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
     }
	
    

    /**
     * Método que permite obtener un pedido según su Id
     * @param idPedido, Id Pedido con el cual se buscara el pedido en BD
     * @return Pedido encontrado
     */
    @GetMapping(value = "/pedido/{idPedido}")
    public ResponseEntity<Pedido> findByPedido(@PathVariable Long idPedido) 
    {
        try
        {
            Pedido pedido = pedidoRepository.findById(idPedido).get();

            return new ResponseEntity<Pedido>(pedido, HttpStatus.OK);
        }
        catch (Exception e) 
        {
			return new ResponseEntity<Pedido>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}