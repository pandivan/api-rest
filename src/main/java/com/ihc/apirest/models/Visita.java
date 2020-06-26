package com.ihc.apirest.models;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
public class Visita
{
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long idVisita;

	private Double temperatura;

	@JoinColumn(name = "idCliente")
    @ManyToOne(optional = false)
    private Cliente cliente;
}