using CadPasteleria;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClnPasteleria
{
    public class ProductoCln
    {
        public static int insertar(Producto producto)
        {
            using (var context = new LabPasteleriaEntities())
            {
                context.Producto.Add(producto);
                context.SaveChanges();
                return producto.id;
            }
        }

        public static int actualizar(Producto producto)
        {
            using (var context = new LabPasteleriaEntities())
            {
                var existe = context.Producto.Find(producto.id);
                existe.nombre = producto.nombre;
                existe.precio = producto.precio;
                existe.tipo = producto.tipo;
                existe.descripcion = producto.descripcion;
                existe.usuarioRegistro = producto.usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static int eliminar(int id, string usuarioRegistro)
        {
            using (var context = new LabPasteleriaEntities())
            {
                var existe = context.Producto.Find(id);
                existe.estado = -1;
                existe.usuarioRegistro = usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static Producto obtenerUno(int id)
        {
            using (var context = new LabPasteleriaEntities())
            {
                return context.Producto.Find(id);
            }
        }

        public static List<Producto> listar()
        {
            using (var context = new LabPasteleriaEntities())
            {
                return context.Producto.Where(x => x.estado != -1).ToList();
            }
        }

        public static List<paListarProductos_Result> listarPa(string parametro)
        {
            using (var context = new LabPasteleriaEntities())
            {
                return context.paListarProductos(parametro).ToList();
            }
        }
    }
}
