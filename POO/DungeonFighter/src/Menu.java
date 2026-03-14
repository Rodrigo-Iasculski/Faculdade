import javax.swing.*;
import java.awt.*;

public class Menu{
    JLabel titulo;
    JFrame janela;
    JPanel painelPrincipal;
    JPanel painelBotoes;
    JButton botaoPlay;
    JButton botaoDebug;
    JButton botaoSair;

    public Menu() {
        //Icones
        ImageIcon imageTitulo = new ImageIcon("Assets/title.png");
        ImageIcon iconePlay = new ImageIcon("Assets/botaoPlay.png");
        ImageIcon iconeDebug = new ImageIcon("Assets/botaoDebug.png");
        ImageIcon iconeSair = new ImageIcon("Assets/botaoSair.png");

        //Resize dos icones(da pra tirar isso se no assets modificar o tamanho dos icones)
        Image imagemPlay = iconePlay.getImage().getScaledInstance(150, 75, Image.SCALE_SMOOTH);
        Image imagemDebug = iconeDebug.getImage().getScaledInstance(150, 75, Image.SCALE_SMOOTH);
        Image imagemSair= iconeSair.getImage().getScaledInstance(150, 65, Image.SCALE_SMOOTH);

        ImageIcon iconePlayResize = new ImageIcon(imagemPlay);
        ImageIcon iconeDebugResize = new ImageIcon(imagemDebug);
        ImageIcon iconeSairResize = new ImageIcon(imagemSair);

        //Título
        titulo = new JLabel(imageTitulo);
        titulo.setHorizontalAlignment(JLabel.CENTER);
        titulo.setBounds(0,100,1920,300);

        //Botões e o painel deles
        botaoPlay = new JButton(iconePlayResize);
        botaoDebug = new JButton(iconeDebugResize);
        botaoSair = new JButton(iconeSairResize);

        JButton[] botoes = {botaoPlay,botaoDebug,botaoSair};
        for(JButton b : botoes) {
            b.setAlignmentX(Component.CENTER_ALIGNMENT);
            b.setBorderPainted(false);
            b.setContentAreaFilled(false);
            b.setFocusPainted(false);
        }
        painelBotoes = new JPanel();
        painelBotoes.setLayout(new BoxLayout(painelBotoes, BoxLayout.Y_AXIS));
        painelBotoes.setBackground(Color.BLACK);

        painelBotoes.add(Box.createVerticalGlue());
        painelBotoes.add(botaoPlay);
        painelBotoes.add(Box.createVerticalStrut(20));
        painelBotoes.add(botaoDebug);
        painelBotoes.add(Box.createVerticalStrut(20));
        painelBotoes.add(botaoSair);
        painelBotoes.add(Box.createVerticalGlue());

        //Painel Principal
        painelPrincipal = new JPanel();
        painelPrincipal.setLayout(new BorderLayout());
        painelPrincipal.add(titulo,BorderLayout.NORTH);
        painelPrincipal.add(painelBotoes,BorderLayout.CENTER);
        painelPrincipal.setBackground(Color.BLACK);

        //Janela
        janela = new JFrame("Dungeon Fighter");
        janela.add(painelPrincipal);
        janela.setSize(1920, 1080);
        janela.setExtendedState(JFrame.MAXIMIZED_BOTH);
        janela.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        janela.setVisible(true);
    }
}
