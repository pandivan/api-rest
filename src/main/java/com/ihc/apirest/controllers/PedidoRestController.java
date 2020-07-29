package com.ihc.apirest.controllers;

import java.util.List;

import com.ihc.apirest.models.Pedido;
import com.ihc.apirest.models.ProductoPedido;
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
     * Método que permite crear un nuevo pedido en BD
     * @param pedido, Pedido a crear
     * @return Pedido creado
     */
    @PostMapping(value="/pedido")
    public ResponseEntity<Boolean> crearPedido(@RequestBody final Pedido pedido)
    {
        try 
        {
            //Se hace un set de pedido en todos los productos, ya que javascript no adminte estructuras ciclicas en el caso de [ProductoPedido] que contiene a [Pedido] 
            //y este a su vez contiene a [ProductoPedido], lo cual imposibilita enviar un entity de [Pedido] desde la App
            for (final ProductoPedido productoPedido : pedido.getLstProductosPedido()) 
            {
                productoPedido.setPedido(pedido);    
            }

            //Este metodo creará una pedido en BD
            pedidoRepository.save(pedido);

            return new ResponseEntity<Boolean>(true, HttpStatus.CREATED);
		} 
        catch (final Exception e) 
        {
            return new ResponseEntity<Boolean>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
     }


     /**
     * Método que permite actualizar una pedido en BD
     * @param pedido, Pedido actualizar
     * @return Pedido actualizado
     */
    @PutMapping("/pedido")
    public ResponseEntity<Boolean> actualizarPedido(@RequestBody final Pedido pedido)
    {
        try 
        {
            //Este metodo creará un usuario en BD.
            pedidoRepository.actualizarPedido(pedido.getIdTienda(), pedido.getIdEstado(), pedido.getIdPedido());
            
            return new ResponseEntity<Boolean>(true, HttpStatus.CREATED);
		} 
        catch (final Exception e) 
        {
            return new ResponseEntity<Boolean>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
     }
	
    

    // /**
    //  * Método que permite obtener un pedido según su Id
    //  * @param idPedido, Id Pedido con el cual se buscara el pedido en BD
    //  * @return Pedido encontrado
    //  */
    // @GetMapping(value = "/pedido/{idPedido}")
    // public ResponseEntity<Pedido> findByPedido(@PathVariable Long idPedido) 
    // {
    //     try
    //     {
    //         Pedido pedido = pedidoRepository.findById(idPedido).get();

    //         return new ResponseEntity<Pedido>(pedido, HttpStatus.OK);
    //     }
    //     catch (Exception e) 
    //     {
	// 		return new ResponseEntity<Pedido>(HttpStatus.INTERNAL_SERVER_ERROR);
    //     }
    // }



    /**
     * Método que permite obtener todos los pedidos activos
     * @return Listado de pedidos activos
     */
    @GetMapping(value = "/pedido")
    public ResponseEntity<List<Pedido>> getAllPedidos() 
    {
        try
        {
            Long idEstadoPendiente = (long) 100;
            
            List<Pedido> lstPedidos = pedidoRepository.findByIdEstado(idEstadoPendiente);

            return new ResponseEntity<List<Pedido>>(lstPedidos, HttpStatus.OK);
        }
        catch (final Exception e) 
        {
			return new ResponseEntity<List<Pedido>>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}