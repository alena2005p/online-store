using System;
using System.Windows;
using Oracle.ManagedDataAccess.Client;

namespace OnlineStore
{
    public partial class ManagerWindow : Window
    {
        string connStr = "User Id=SYSTEM;Password=wrt56llm;Data Source=localhost:1521/xepdb1";

        public ManagerWindow()
        {
            InitializeComponent();
        }

        private void BtnAdd_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                using (OracleConnection conn = new OracleConnection(connStr))
                {
                    conn.Open();
                    OracleCommand cmdMax = new OracleCommand("SELECT NVL(MAX(Product_ID), 0) + 1 FROM Products_3NF", conn);
                    int newId = Convert.ToInt32(cmdMax.ExecuteScalar());

                    string insertQuery = "INSERT INTO Products_3NF (Product_ID, Product_Name, Category_ID) VALUES (:id, :name, :catId)";
                    OracleCommand cmd = new OracleCommand(insertQuery, conn);
                    cmd.Parameters.Add(new OracleParameter("id", newId));
                    cmd.Parameters.Add(new OracleParameter("name", TxtName.Text));
                    cmd.Parameters.Add(new OracleParameter("catId", int.Parse(TxtCategoryId.Text)));

                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Товар успешно добавлен!");
                    this.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка: " + ex.Message);
            }
        }
    }
}