using CadPasteleria;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClnPasteleria
{
    public class EmpleadoCln
    {
        public static int insertar(Empleado empleado)
        {
            using (var context = new LabPasteleriaEntities())
            {
                context.Empleado.Add(empleado);
                context.SaveChanges();
                return empleado.id;
            }
        }
        public static int actualizar(Empleado empleado)
        {
            using (var context = new LabPasteleriaEntities())
            {
                var existe = context.Empleado.Find(empleado.id);
                existe.cedulaIdentidad = empleado.cedulaIdentidad;
                existe.nombres = empleado.nombres;
                existe.apellidoPaterno = empleado.apellidoPaterno;
                existe.apellidoMaterno = empleado.apellidoMaterno;
                existe.fechaNacimiento = empleado.fechaNacimiento;
                existe.direccion = empleado.direccion;
                existe.celular = empleado.celular;
                existe.cargo = empleado.cargo;
                existe.usuarioRegistro = empleado.usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static int eliminar(int id, string usuarioRegistro)
        {
            using (var context = new LabPasteleriaEntities())
            {
                var existe = context.Empleado.Find(id);
                existe.estado = -1;
                existe.usuarioRegistro = usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static Empleado obtenerUno(int id)
        {
            using (var context = new LabPasteleriaEntities())
            {
                return context.Empleado.Find(id);
            }
        }

        public static List<Empleado> listar()
        {
            using (var context = new LabPasteleriaEntities())
            {
                return context.Empleado.Where(x => x.estado != -1).ToList();
            }
        }

        public static List<paListarEmpleados_Result> listarPa(string parametro)
        {
            using (var context = new LabPasteleriaEntities())
            {
                return context.paListarEmpleados(parametro).ToList();
            }
        }
    }
}
