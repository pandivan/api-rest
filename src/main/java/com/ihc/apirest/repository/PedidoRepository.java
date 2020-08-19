package com.ihc.apirest.repository;

import java.util.List;

import com.ihc.apirest.models.Cliente;
import com.ihc.apirest.models.Pedido;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;



@Repository
public interface PedidoRepository extends JpaRepository<Pedido, Long>
{
    /**
     * Método que permite actualizar el pedido
     * @param idTienda Id de la tienda que tomo el pedido
     * @param idEstado Id del estado Aceptado
     * @param idPedido Id del pedido
     */
    @Transactional
    @Modifying
    @Query("update Pedido p SET p.idTienda = ?1, p.idEstado = ?2 where p.idPedido = ?3")
    void actualizarPedido(Long idTienda, Long idEstado, Long idPedido);


    /**
     * Método que permite actualizar el pedido
     * @param idTienda Id de la tienda que tomo el pedido
     * @param idEstado Id del estado Aceptado
     * @param idPedido Id del pedido
     */
    @Transactional
    @Modifying
    @Query("update Pedido p SET p.idEstado = ?1 where p.idPedido = ?2")
    void actualizarEstadoPedido(Long idEstado, Long idPedido);


    /**
     * Método que permite obtener un pedido según su estado
     * @param idEstado Id estado del pedido
     * @param idPedido Id del pedido
     * @return Pedido
     */
    @Query("select p.idPedido from Pedido p where p.idPedido = ?1 and p.idEstado = ?2")
    Long findByIdPedidoAndIdEstado(Long idPedido, Long idEstado);


    /**
     * Método que permite obtener todos los pedidos según su estado
     * @param idEstado Id estado
     * @return Listado de pedidos
     */
    List<Pedido> findByIdEstado(Long idEstado);



    /**
     * Método que permite obtener todos los pedidos de una tienda con estado "ACEPTADO"
     * @param idTienda Id del tienda
     * @param idEstado Id del estado
     * @return Listado de pedidos aceptados
     */
    List<Pedido> findByIdTiendaAndIdEstado(Long idTienda, Long idEstado);



    /**
     * Método que permite obtener todos los pedidos del cliente del día actual
     * @param idCliente Id del cliente
     * @param idEstado Id del estado
     * @return Listado de pedidos aceptados
     */
    List<Pedido> findByCliente(Cliente cliente);
}