package com.ihc.apirest.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;



@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
public class Cliente
{
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long idCliente;
	private String cedula;
	private String nombre;
	private String apellido;
	private String barrio;
	private String telefono;
	private String sexo;

	// @OneToMany(cascade = CascadeType.ALL)
	// @JoinColumn(name ="idCliente")
	// private List<Visita> lstVisitas;

	@OneToMany(mappedBy = "cliente", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Visita> lstVisitas;
}