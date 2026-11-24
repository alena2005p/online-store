using System.Windows;

namespace OnlineStore
{
    public partial class CartWindow : Window
    {
        public CartWindow()
        {
            InitializeComponent();
        }

        private void BtnCheckout_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Заказ оформлен!");
            this.Close();
        }
    }
}