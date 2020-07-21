package com.ihc.apirest.repository;

import com.ihc.apirest.models.Producto;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;



@Repository
public interface ProductoRepository extends JpaRepository<Producto, Long>
{
}