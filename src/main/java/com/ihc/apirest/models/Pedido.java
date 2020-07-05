package com.ihc.apirest.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;



@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
// @Table(name="hechos.pedidos")
public class Pedido
{
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long idPedido;
	private Long idTienda;
	private Long idProducto;
	private Long idCliente;
	private Long idTiempo;
	private Long idEstado;
	private int cantidad;
	private Double valor;
}