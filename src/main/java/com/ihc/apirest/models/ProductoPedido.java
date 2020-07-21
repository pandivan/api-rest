package com.ihc.apirest.models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;



@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
@Table(schema="dimension")
public class ProductoPedido
{
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long idProductoPedido;
	private int cantidad;
	private Double valor;

	@JoinColumn(name = "idProducto")
    @ManyToOne(optional = false)
	private Producto producto;

	@JoinColumn(name = "idPedido")
	@ManyToOne(optional = false)
	@JsonIgnore
    private Pedido pedido;
}