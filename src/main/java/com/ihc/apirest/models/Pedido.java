package com.ihc.apirest.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;



@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
@Table(schema="dimension")
public class Pedido
{
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long idPedido;
	private Long idTienda;
	private Long idEstado;

	@OneToMany(mappedBy = "pedido", cascade = CascadeType.ALL)
    private List<Venta> lstVentas;
}