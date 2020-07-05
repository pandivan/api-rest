package com.ihc.apirest.repository;

import com.ihc.apirest.models.Tienda;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;



@Repository
public interface TiendaRepository extends JpaRepository<Tienda, Long>
{   
    Tienda findByNit(String nit);
}