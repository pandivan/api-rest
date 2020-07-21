package com.ihc.apirest.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ihc.apirest.models.Categoria;
import com.ihc.apirest.models.Producto;
import com.ihc.apirest.repository.ProductoRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;



@RestController
@RequestMapping("/api")
public class ProductoRestController 
{
    @Autowired
    ProductoRepository productoRepository;
	
    

    /**
     * Método que permite obtener un producto según su Id
     * @param idProducto, Id Producto con el cual se buscara el producto en BD
     * @return Producto encontrado
     */
    @GetMapping(value = "/productos")
    public ResponseEntity<List<Categoria>> findAllCategoriasProductos() 
    {
        try
        {
            Map<String, Categoria> mapCategorias = new HashMap<String, Categoria>();
            List<Producto> lstProductos = null;

            List<Producto> lstProductosBD = productoRepository.findAll();

            String nombreCategoria = "";

            for (Producto producto : lstProductosBD) 
            {
                if(nombreCategoria.equals(producto.getCategoriaNivel1()))
                {
                    mapCategorias.get(nombreCategoria).getLstProductos().add(producto);
                }
                else
                {
                    nombreCategoria = producto.getCategoriaNivel1();

                    lstProductos = new ArrayList<Producto>();
                    lstProductos.add(producto);

                    //TODO: Quitar el tema del color
                    String color = "";
                    if("American".equals(nombreCategoria))
                    {
                        color = "#fbc831";
                    }
                    else if("Burger".equals(nombreCategoria))
                    {
                        color = "#9fd236";
                    }
                    else if("Pizza".equals(nombreCategoria))
                    {
                        color = "orange";
                    }
                    else if("Drink".equals(nombreCategoria))
                    {
                        color = "#f2f2f2";
                    }

                    mapCategorias.put(nombreCategoria, new Categoria(nombreCategoria, producto.getUrlImagenCategoria(), color, lstProductos));
                }
            }

            return new ResponseEntity<List<Categoria>>(new ArrayList<Categoria>(mapCategorias.values()), HttpStatus.OK);
        }
        catch (Exception e) 
        {
			return new ResponseEntity<List<Categoria>>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}