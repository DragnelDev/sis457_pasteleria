using CadPasteleria;
using ClnPasteleria;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CpPasteleria
{
    public partial class FrmProducto : Form
    {
        private bool esNuevo = false;
        public FrmProducto()
        {
            InitializeComponent();
        }
        private void listar()
        {
            var lista = ProductoCln.listarPa(txtBuscar.Text.Trim());
            dgvLista.DataSource = lista;
            dgvLista.Columns["id"].Visible = false;
            dgvLista.Columns["nombre"].HeaderText = "Nombre";
            dgvLista.Columns["precio"].HeaderText = "Precio";
            dgvLista.Columns["tipo"].HeaderText = "Tipo";            dgvLista.Columns["descripcion"].HeaderText = "Descripción";
            dgvLista.Columns["estado"].Visible = false;
            dgvLista.Columns["usuarioRegistro"].HeaderText = "Usuario Registro";
            dgvLista.Columns["fechaRegistro"].HeaderText = "Fecha de Registro";
            /*
                        if (lista.Count > 0) dgvProductos.CurrentCell = dgvProductos.Rows[0].Cells["id"];
                        btnEditar.Enabled = lista.Count > 0;
                        btnEliminar.Enabled = lista.Count > 0;*/
        }

        private void FrmProducto_Load(object sender, EventArgs e)
        {
            Size = new Size(682, 298);
            listar();
        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            esNuevo = true;
            //pnlAcciones.Enabled = false;
            Size = new Size(682, 430);
            //txtCodigo.Focus();
        }

        private void btnEditar_Click(object sender, EventArgs e)
        {
            esNuevo = false;
            //pnlAcciones.Enabled = false;
            Size = new Size(682, 430);
            /*
            int id = (int)dgvLista.CurrentRow.Cells["id"].Value;
            var producto = ProductoCln.obtenerUno(id);
            txtCodigo.Text = producto.codigo;
            txtDescripcion.Text = producto.descripcion;
            cbxUnidadMedida.SelectedValue = producto.idUnidadMedida;
            nudSaldo.Value = producto.saldo;
            nudPrecioVenta.Value = producto.precioVenta;

            txtCodigo.Focus();*/

        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            Size = new Size(682, 298);
            //pnlAcciones.Enabled = true;
            //limpiar();
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            listar();
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {

        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {

        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
