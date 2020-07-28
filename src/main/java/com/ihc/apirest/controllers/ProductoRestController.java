package com.ihc.apirest.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ihc.apirest.models.Catalogo;
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
    public ResponseEntity<Catalogo> findAllCategoriasProductos() 
    {
        try
        {
            List<Categoria> lstCategorias = new ArrayList<Categoria>();

            Catalogo catalogo = new Catalogo();

            List<Producto> lstProductosBD = productoRepository.findAll();

            String idCategoria = "";

            for (Producto producto : lstProductosBD) 
            {
                if(!idCategoria.equals(producto.getCategoriaNivel1()))
                {
                    idCategoria = producto.getCategoriaNivel1();

                    //TODO: Quitar el tema del color
                    String color = "";
                    if("American".equals(idCategoria))
                    {
                        color = "#fbc831";
                    }
                    else if("Burger".equals(idCategoria))
                    {
                        color = "#9fd236";
                    }
                    else if("Pizza".equals(idCategoria))
                    {
                        color = "orange";
                    }
                    else if("Drink".equals(idCategoria))
                    {
                        color = "#f2f2f2";
                    }

                    lstCategorias.add(new Categoria(idCategoria, producto.getCategoriaNivel1(), producto.getUrlImagenCategoria(), color, null));
                }
            }

            catalogo.setLstCategorias(lstCategorias);
            catalogo.setLstProductos(lstProductosBD);

            return new ResponseEntity<Catalogo>(catalogo, HttpStatus.OK);
        }
        catch (Exception e) 
        {
			return new ResponseEntity<Catalogo>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    

    // /**
    //  * Método que permite obtener un producto según su Id
    //  * @param idProducto, Id Producto con el cual se buscara el producto en BD
    //  * @return Producto encontrado
    //  */
    // @GetMapping(value = "/productos")
    // public ResponseEntity<List<Categoria>> findAllCategoriasProductos() 
    // {
    //     try
    //     {
    //         Map<String, Categoria> mapCategorias = new HashMap<String, Categoria>();

    //         List<Producto> lstProductos = null;

    //         List<Producto> lstProductosBD = productoRepository.findAll();

    //         String idCategoria = "";

    //         for (Producto producto : lstProductosBD) 
    //         {
    //             if(idCategoria.equals(producto.getCategoriaNivel1()))
    //             {
    //                 mapCategorias.get(idCategoria).getLstProductos().add(producto);
    //             }
    //             else
    //             {
    //                 idCategoria = producto.getCategoriaNivel1();

    //                 lstProductos = new ArrayList<Producto>();
    //                 lstProductos.add(producto);

    //                 //TODO: Quitar el tema del color
    //                 String color = "";
    //                 if("American".equals(idCategoria))
    //                 {
    //                     color = "#fbc831";
    //                 }
    //                 else if("Burger".equals(idCategoria))
    //                 {
    //                     color = "#9fd236";
    //                 }
    //                 else if("Pizza".equals(idCategoria))
    //                 {
    //                     color = "orange";
    //                 }
    //                 else if("Drink".equals(idCategoria))
    //                 {
    //                     color = "#f2f2f2";
    //                 }

    //                 mapCategorias.put(idCategoria, new Categoria(idCategoria, producto.getCategoriaNivel1(), producto.getUrlImagenCategoria(), color, lstProductos));
    //             }
    //         }

    //         return new ResponseEntity<List<Categoria>>(new ArrayList<Categoria>(mapCategorias.values()), HttpStatus.OK);
    //     }
    //     catch (Exception e) 
    //     {
	// 		return new ResponseEntity<List<Categoria>>(HttpStatus.INTERNAL_SERVER_ERROR);
    //     }
    // }
}