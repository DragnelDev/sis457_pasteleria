using CadPasteleria;
using ClnPasteleria;
using CpMinerva;
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
            dgvLista.Columns["codigo"].HeaderText = "Código";
            dgvLista.Columns["nombre"].HeaderText = "Nombre";
            dgvLista.Columns["precio"].HeaderText = "Precio";
            dgvLista.Columns["tipo"].HeaderText = "Tipo";            
            dgvLista.Columns["descripcion"].HeaderText = "Descripción";
            dgvLista.Columns["estado"].Visible = false;
            dgvLista.Columns["usuarioRegistro"].HeaderText = "Usuario Registro";
            dgvLista.Columns["fechaRegistro"].HeaderText = "Fecha de Registro";

            if (lista.Count > 0) dgvLista.CurrentCell = dgvLista.Rows[0].Cells["codigo"];
            btnEditar.Enabled = lista.Count > 0;
            btnEliminar.Enabled = lista.Count > 0;
        }

        private void FrmProducto_Load(object sender, EventArgs e)
        {
            Size = new Size(682, 298);
            listar();
        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            esNuevo = true;
            pnlAcciones.Enabled = false;
            Size = new Size(682, 430);
            txtNombre.Focus();
        }

        private void btnEditar_Click(object sender, EventArgs e)
        {
            esNuevo = false;
            pnlAcciones.Enabled = false;
            Size = new Size(682, 430);
            
            int id = (int)dgvLista.CurrentRow.Cells["id"].Value;
            var producto = ProductoCln.obtenerUno(id);
            txtCodigo.Text = producto.codigo;
            txtNombre.Text = producto.nombre;
            txtDescripcion.Text = producto.descripcion;
            txtTipoProducto.Text = producto.tipo;
            nudPrecio.Value = producto.precio;

            txtCodigo.Focus();

        }

        private void limpiar()
        {
            txtCodigo.Clear();
            txtNombre.Clear();
            txtDescripcion.Clear();
            txtTipoProducto.Clear();
            nudPrecio.Value = 0;
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            Size = new Size(682, 298);
            pnlAcciones.Enabled = true;
            limpiar();
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            listar();
        }

        private void txtBuscar_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Enter) listar();
        }

        private bool validar()
        {
            bool esValido = true;
            erpCodigo.Clear();
            erpNombreProducto.Clear();
            erpDescripcion.Clear();
            erpPrecio.Clear();
            erpTipoProducto.Clear();

            if (string.IsNullOrEmpty(txtCodigo.Text))
            {
                erpCodigo.SetError(txtCodigo, "El Código es obligatorio");
                esValido = false;
            }
            if (string.IsNullOrEmpty(txtNombre.Text))
            {
                erpNombreProducto.SetError(txtNombre, "El Nombre del Producto es obligatorio");
                esValido = false;
            }
            if (string.IsNullOrEmpty(txtDescripcion.Text))
            {
                erpDescripcion.SetError(txtDescripcion, "La Descripción es obligatoria");
                esValido = false;
            }
            if (string.IsNullOrEmpty(txtTipoProducto.Text))
            {
                erpTipoProducto.SetError(txtTipoProducto, "El Tipo de producto es obligatoria");
                esValido = false;
            }
            if (nudPrecio.Value == 0)
            {
                erpPrecio.SetError(nudPrecio, "El Precio de Venta debe ser mayor a cero");
                esValido = false;
            }

            return esValido;
        }
        private void btnGuardar_Click(object sender, EventArgs e)
        {
            if (validar())
            {
                var producto = new Producto();
                producto.codigo = txtCodigo.Text.Trim();
                producto.nombre = txtNombre.Text.Trim();
                producto.descripcion = txtDescripcion.Text.Trim();
                producto.tipo = txtTipoProducto.Text.Trim();
                producto.precio = nudPrecio.Value;
                producto.usuarioRegistro = Util.usuario.usuario1;

                if (esNuevo)
                {
                    producto.fechaRegistro = DateTime.Now;
                    producto.estado = 1;
                    ProductoCln.insertar(producto);
                }
                else
                {
                    producto.id = (int)dgvLista.CurrentRow.Cells["id"].Value;
                    ProductoCln.actualizar(producto);
                }
                listar();
                btnCancelar.PerformClick();
                MessageBox.Show("Producto guardado correctamente", "::: Mensaje - Pasteleria :::",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            int id = (int)dgvLista.CurrentRow.Cells["id"].Value;
            string codigo = dgvLista.CurrentRow.Cells["codigo"].Value.ToString();
            DialogResult dialog = MessageBox.Show($"¿Está seguro de eliminar el producto {codigo}?",
                "::: Mensaje - Pasteleria :::", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (dialog == DialogResult.Yes)
            {
                ProductoCln.eliminar(id, Util.usuario.usuario1);
                listar();
                MessageBox.Show("Producto dado de baja correctamente", "::: Mensaje - Pasteleria :::",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
