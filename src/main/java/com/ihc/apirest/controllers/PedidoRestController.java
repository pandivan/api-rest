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

    static final Long ID_ESTADO_PENDIENTE = (long) 100;
    static final Long ID_ESTADO_ACEPTADO = (long) 101;


    /**
     * Método que permite crear un nuevo pedido
     * @param pedido, Pedido a crear
     * @return True si el pedido fue creado, en caso contrario False
     */
    @PostMapping(value="/pedido")
    public ResponseEntity<Boolean> crearPedido(@RequestBody Pedido pedido)
    {
        try 
        {
            //Se hace un set de pedido en todos los productos, ya que javascript no adminte estructuras ciclicas en el caso de [ProductoPedido] que contiene a [Pedido] 
            //y este a su vez contiene a [ProductoPedido], lo cual imposibilita enviar un entity de [Pedido] desde la App
            for (ProductoPedido productoPedido : pedido.getLstProductosPedido()) 
            {
                productoPedido.setPedido(pedido);    
            }

            //Este metodo creará una pedido
            pedidoRepository.save(pedido);

            return new ResponseEntity<Boolean>(true, HttpStatus.CREATED);
		} 
        catch (Exception e) 
        {
            return new ResponseEntity<Boolean>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
     }


     /**
     * Método que permite actualizar una pedido
     * @param pedido, Pedido actualizar
     * @return True si el pedido fue actualizado, en caso contrario False
     */
    @PutMapping("/pedido")
    public ResponseEntity<Boolean> actualizarPedido(@RequestBody Pedido pedido)
    {
        boolean isActualizado = false;
        try 
        {
            //Validamos que el pedido siga pendiente y que ninguna tienda lo haya tomado antes
            Long idPedidoPendiente = pedidoRepository.findByIdPedidoAndIdEstado(pedido.getIdPedido(), ID_ESTADO_PENDIENTE);

            if(null != idPedidoPendiente)
            {
                //Actualizando el estado del pedido con la tienda que lo tomó
                pedidoRepository.actualizarPedido(pedido.getIdTienda(), ID_ESTADO_ACEPTADO, pedido.getIdPedido());
                isActualizado = true;
            }
            
            return new ResponseEntity<Boolean>(isActualizado, HttpStatus.CREATED);
		} 
        catch (Exception e) 
        {
            return new ResponseEntity<Boolean>(isActualizado, HttpStatus.INTERNAL_SERVER_ERROR);
		}
     }



     /**
     * Método que permite actualizar el estado de un pedido
     * @param pedido, Pedido actualizar
     * @return True si el pedido fue actualizado, en caso contrario False
     */
    @PutMapping("/pedido/estado")
    public ResponseEntity<Boolean> actualizarEstadoPedido(@RequestBody Pedido pedido)
    {
        try 
        {
            //Actualizando el estado del pedido
            pedidoRepository.actualizarEstadoPedido(pedido.getIdEstado(), pedido.getIdPedido());
            
            return new ResponseEntity<Boolean>(true, HttpStatus.CREATED);
		} 
        catch (Exception e) 
        {
            return new ResponseEntity<Boolean>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
     }



    /**
     * Método que permite obtener todos los pedidos PENDIENTES
     * @return Listado de pedidos
     */
    @GetMapping(value = "/pedido")
    public ResponseEntity<List<Pedido>> getAllPedidos() 
    {
        try
        {
            List<Pedido> lstPedidos = pedidoRepository.findByIdEstado(ID_ESTADO_PENDIENTE);

            return new ResponseEntity<List<Pedido>>(lstPedidos, HttpStatus.OK);
        }
        catch (Exception e) 
        {
			return new ResponseEntity<List<Pedido>>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }



    /**
     * Método que permite obtener todos los pedidos aceptados por la tienda
     * @return Listado de pedidos
     */
    @GetMapping(value = "/pedido/{idTienda}")
    public ResponseEntity<List<Pedido>> getAllHistorialPedidosTienda(@PathVariable("idTienda") Long idTienda)
    {
        try
        {
            List<Pedido> lstPedidos = pedidoRepository.findByIdTiendaAndIdEstado(idTienda, ID_ESTADO_ACEPTADO);

            return new ResponseEntity<List<Pedido>>(lstPedidos, HttpStatus.OK);
        }
        catch (Exception e) 
        {
			return new ResponseEntity<List<Pedido>>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}