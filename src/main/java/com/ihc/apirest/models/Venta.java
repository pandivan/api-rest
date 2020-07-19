package com.ihc.apirest.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;



@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
@Table(schema="hechos")
public class Venta
{
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long idVenta;
	// private Long idPedido;
	private Long idProducto;
	private Long idCliente;
	private int cantidad;
	private Double valor;

	@JoinColumn(name = "idPedido")
    @ManyToOne(optional = false)
    private Pedido pedido;
	
	// @JoinColumn(name = "idProducto")
    // @ManyToOne(optional = false)
	// private Producto producto;
	
	// @JoinColumn(name = "idCliente")
    // @ManyToOne(optional = false)
    // private Cliente cliente;
}