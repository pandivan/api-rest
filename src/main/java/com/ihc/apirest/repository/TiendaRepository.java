package com.ihc.apirest.repository;

import com.ihc.apirest.models.Tienda;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;



@Repository
public interface TiendaRepository extends JpaRepository<Tienda, Long>
{   
    @Query("select t from Tienda t where (t.telefono = ?1 or t.email = ?2) and t.password = ?3")
    Tienda validarTienda(String telefono, String nit, String password);
}