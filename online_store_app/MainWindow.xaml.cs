using System;
using System.Windows;
using System.Data;
using Oracle.ManagedDataAccess.Client;

namespace OnlineStore
{
    public partial class MainWindow : Window
    {
        string connStr = "User Id=SYSTEM;Password=ТВОЙ_ПАРОЛЬ;Data Source=localhost:1521/xepdb1";

        public MainWindow()
        {
            InitializeComponent();
            LoadData();
        }

        private void LoadData()
        {
            try
            {
                using (OracleConnection conn = new OracleConnection(connStr))
                {
                    conn.Open();
                    string query = "SELECT Product_ID, Product_Name FROM Products_3NF";
                    OracleDataAdapter da = new OracleDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    ProductsGrid.ItemsSource = dt.DefaultView;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка БД: " + ex.Message);
            }
        }

        private void BtnAddToCart_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Товар добавлен в корзину!");
        }

        private void BtnOpenCart_Click(object sender, RoutedEventArgs e)
        {
            CartWindow cart = new CartWindow();
            cart.Show();
        }

        private void BtnManager_Click(object sender, RoutedEventArgs e)
        {
            ManagerWindow manager = new ManagerWindow();
            manager.Show();
        }
    }
}