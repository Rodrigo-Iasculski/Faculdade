import java.awt.CardLayout;
import javax.swing.*;

public class Paineis {
    Menu menu;
    SelecaoPersonagem selecaoPersonagem;
    JFrame janela;
    JPanel paineis;
    CardLayout layoutPaineis;
    JPanel painelSelecaoPersonagem;
    JPanel painelMenu;

    public Paineis () {

        layoutPaineis = new CardLayout(); 
        paineis = new JPanel();
        paineis.setLayout(layoutPaineis);
        menu = new Menu(this);
        selecaoPersonagem = new SelecaoPersonagem(this);

        painelSelecaoPersonagem = selecaoPersonagem.painelPrincipal;
        painelMenu = menu.painelPrincipal;

        paineis.add(painelMenu, "Painel do Menu");
        paineis.add(painelSelecaoPersonagem, "Painel de Selecao de Personagem");

        janela = new JFrame("Dungeon Fighter");
        janela.add(paineis);
        janela.setSize(1200, 800);
        janela.setExtendedState(JFrame.MAXIMIZED_BOTH);
        janela.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        janela.setVisible(true);
    }
}