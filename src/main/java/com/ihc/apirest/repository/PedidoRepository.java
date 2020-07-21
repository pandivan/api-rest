package com.ihc.apirest.repository;

import com.ihc.apirest.models.Pedido;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;



@Repository
public interface PedidoRepository extends JpaRepository<Pedido, Long>
{
    @Transactional
    @Modifying
    @Query("update Pedido p SET p.idTienda = ?1, p.idEstado = ?2 where p.idPedido = ?3")
    void actualizarPedido(Long idTienda, Long idEstado, Long idPedido);
}